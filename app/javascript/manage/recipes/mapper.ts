interface StepIngredient {
    amount: number;
    condition: string;
    unit: string;

    name: string;
    description: string;
}

interface Step {
    instruction: string;
    order: number;

    ingredients: Array<StepIngredient>
}

interface Recipe {
    name: string;
    image_url: string;
    description: string;

    steps: Array<Step>;
}

interface RecipeResponse {
    name: string;
    image_url: string;
    description: string;
    created_at: Date;
    updated_at: Date;

    steps: Array<StepResponse>
}

interface IngredientResponse {
    name: string;
    description: string;
    created_at: Date;
    updated_at: Date;

    step_ingredients: Array<StepIngredientResponse>
}

interface StepIngredientResponse {
    amount: number;
    condition: string;
    unit: string;
    created_at: Date;
    updated_at: Date;

    ingredient: IngredientResponse;
    step: StepResponse;
}

interface StepResponse {
    instruction: string;
    order: number;
    created_at: Date;
    updated_at: Date;

    step_ingredients: Array<StepIngredientResponse>;
}

const recipeAPIToClient = (recipe: RecipeResponse): Recipe => {
    return {
        name: recipe.name,
        description: recipe.description,
        image_url: recipe.image_url,
        steps: recipe.steps.map((step: StepResponse): Step => stepAPIToClient(step))
    }
};

const stepAPIToClient = (step: StepResponse): Step => {
    return {
        instruction: step.instruction,
        order: step.order,
        ingredients: step.step_ingredients.map((stepIngredient: StepIngredientResponse): StepIngredient => stepIngredientAPIToClient(stepIngredient))
    }
};

const stepIngredientAPIToClient = (stepIngredient: StepIngredientResponse): StepIngredient => {
  return {
      amount: stepIngredient.amount,
      condition: stepIngredient.condition,
      unit: stepIngredient.unit,
      name: stepIngredient.ingredient.name,
      description: stepIngredient.ingredient.description
  }
};