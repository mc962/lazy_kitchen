# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Rails.env.production?
  ActiveRecord::Base.transaction do
    user = User.new({**Faker::Internet.user('username', 'email'), password: 'password'})

    spelt_flour =
      Ingredient.new(
        user: user,
        name: "Spelt Flour",
        description: "Flour ground from primitive relative of modern wheat"
      )

    water =
      Ingredient.new(
        user: user,
        name: "Water",
        description: "Plain water, H20"
      )

    starter =
      Ingredient.new(
        user: user,
        name: "Sourdough Starter",
        description: "Starter used to make sourdough bread"
      )

    all_purpose_flour =
      Ingredient.new(
        user: user,
        name: "All-Purpose Flour",
        description: "Generic flour that can be used in many recipes"
      )

    levain =
      Ingredient.new(
        user: user,
        name: "Levain",
        description:
          "An offshoot of a sourdough starter that is mix of fresh flour, water, and maybe a little bit of starter."
      )

    unsalted_butter =
      Ingredient.new(
        user: user,
        name: "Unsalted Butter",
        description: "Butter, churned from dairy, the unsalted variety"
      )

    honey =
      Ingredient.new(
        user: user,
        name: "Honey",
        description: "Sweet, sticky, and produced by bees"
      )

    salt =
      Ingredient.new(
        user: user,
        name: "Salt",
        description: "Flavorful table salt"
      )

    instant_yeast =
      Ingredient.new(
        user: user,
        name: "Instant Yeast",
        description: "Useful microbes for rising tasty breads"
      )

    recipe = Recipe.new(
      name: "Pain au Levain",
      image_url: "https://seethings.s3.amazonaws.com/118810714_10157682000183652_1417595698238834363_n.jpg",
      description: "Delicious sourdough bread",
      publicly_accessible: true,
      user: user
    )

    steps = [
      Step.new(
        recipe: recipe,
        order: 1,
        instruction: "Make the levain the night before you plan to bake the bread. Mix the spelt flour, water, and starter in a bowl, cover, and set aside at room temperature for 12 hours, or overnight. After this time, the levain should be expanded and quite bubbly, but should not have started to fall yet.",
        step_ingredients: [
          StepIngredient.new(
            amount: 99,
            unit: "gram",
            ingredient: spelt_flour
          ),
          StepIngredient.new(
            amount: 113,
            unit: "gram",
            condition: "room temperature",
            ingredient: water
          ),
          StepIngredient.new(
            amount: 1,
            unit: "tablespoon",
            condition: "ripe, fed",
            ingredient: starter
          )
        ]
      ),
      Step.new(
        recipe: recipe,
        order: 2,
        instruction: "On the next day, when you plan to bake the bread, measure out the flours. Combine them with all the levain, along with the remaining dough ingredients.",
        step_ingredients: [
          StepIngredient.new(
            amount: 298,
            unit: "gram",
            ingredient: spelt_flour
          ),
          StepIngredient.new(
            amount: 177,
            unit: "gram",
            ingredient: all_purpose_flour
          ),
          StepIngredient.new(
            amount: 1,
            ingredient: levain
          ),
          StepIngredient.new(
            amount: 227,
            unit: "gram",
            condition: "lukewarm",
            ingredient: water
          ),
          StepIngredient.new(
            amount: 28,
            unit: "gram",
            condition: "melted",
            ingredient: unsalted_butter
          ),
          StepIngredient.new(
            amount: 43,
            unit: "gram",
            ingredient: honey
          ),
          StepIngredient.new(
            amount: 8,
            unit: "gram",
            ingredient: salt
          ),
          StepIngredient.new(
            amount: 0.5,
            unit: "teaspoon",
            ingredient: instant_yeast
          )
        ]
      ),
      Step.new(
        recipe: recipe,
        order: 3,
        instruction: "Mix and knead everything together, either by hand, mixer, or bread machine set on the dough cycle. Continue until you get a smooth, elastic dough. Out of all the all purpose flour, only incorporate as much as is necessary to keep the dough from sticking."
      ),
      Step.new(
        recipe: recipe,
        order: 4,
        instruction: "Let the dough rise, covered, for about 1 hour. It might not double in that time, but it will likely start to get puffy."
      ),
      Step.new(
        recipe: recipe,
        order: 5,
        instruction: "While the dough is rising, grease a covered load baker."
      ),
      Step.new(
        recipe: recipe,
        order: 6,
        instruction: "After that hour rise, remove the dough from the bowl and shape it into a 9” log. Place the dough load into the baker, cover it with the lid, and let it rise for 1 to 1.5 hours."
      ),
      Step.new(
        recipe: recipe,
        order: 7,
        instruction: "About 30 minutes before you plan to bake, preheat the oven to 450 degrees Fahrenheit."
      ),
      Step.new(
        recipe: recipe,
        order: 8,
        instruction: "Remove the lid of the baker and slash the load lengthwise down the center; dusting the load lightly with flour will help make a neater slash, and may improve the look of the loaf. Place the cover back on the baker."
      ),
      Step.new(
        recipe: recipe,
        order: 9,
        instruction: "Bake the bread for 10 minutes, then reduce the heat from 450 degrees Fahrenheit down to 400 degrees Fahrenheit, and bake for 25-30 minutes longer. After that, remove the lid and bake for another 5 minutes or so, until the loaf is nicely golden. A digital thermometer inserted into the center of the load should read about 190 degrees Fahrenheit."
      ),
      Step.new(
        recipe: recipe,
        order: 10,
        instruction: "Remove the loaf from the oven and turn it out of the baker immediately. Let it cool thoroughly before slicing."
      ),
      Step.new(
        recipe: recipe,
        order: 11,
        instruction: "Store bread at room temperature, for up to several days, and keep it well wrapped. Freeze if longer-term storage is desired."
      )
    ]

    citations = [
      Citation.new(
        origin: 'ADAPTED',
        content_type: 'SITE',
        publisher: 'King Arthur Baking Company',
        publication_title: 'Honey Spelt Sourdough Bread',
        last_accessed_at: Date.today,
        site_title: 'King Arthur Baking',
        site_link: 'https://www.kingarthurbaking.com/recipes/honey-spelt-sourdough-bread-recipe',
        recipe: recipe
      )
    ]

    authors = [
      Author.new(
        first_name: 'Bob',
        last_name: 'Builder',
        citation: citations.first
      ),
      Author.new(
        first_name: 'Rob',
        last_name: 'Ruler',
        citation: citations.first
      )
    ]

    recipe.save!
    steps.each(&:save!)
    citations.each(&:save!)
    authors.each(&:save!)
  end
end
