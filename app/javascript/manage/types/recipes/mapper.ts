export interface StepIngredient {
    id?: number;
    amount: number;
    condition: string;
    unit: string;

    name: string;
    description: string;
}

export interface Step {
    id?: number;
    instruction: string;
    order: number;

    ingredients: Array<StepIngredient>
}

export interface Recipe {
    id?: number;
    name: string;
    image_url: string;
    description: string;

    steps: Array<Step>;
}

export interface RecipeResponse {
    id?: number;
    name: string;
    image_url: string;
    description: string;
    created_at: Date;
    updated_at: Date;

    steps: Array<StepResponse>
}

interface IngredientResponse {
    id?: number;
    name: string;
    description: string;
    created_at: Date;
    updated_at: Date;

    step_ingredients: Array<StepIngredientResponse>
}

interface StepIngredientResponse {
    id?: number;
    amount: number;
    condition: string;
    unit: string;
    created_at: Date;
    updated_at: Date;

    ingredient: IngredientResponse;
    step: StepResponse;
}

interface StepResponse {
    id?: number;
    instruction: string;
    order: number;
    created_at: Date;
    updated_at: Date;

    step_ingredients: Array<StepIngredientResponse>;
}

export const recipeAPIToClient = (recipe: RecipeResponse): Recipe => {
    return {
        name: recipe.name,
        description: recipe.description,
        image_url: recipe.image_url,
        steps: recipe.steps.map((step: StepResponse): Step => stepAPIToClient(step))
    }
};

const stepAPIToClient = (step: StepResponse): Step => {
    return {
        id: step.id,
        instruction: step.instruction,
        order: step.order,
        ingredients: step.step_ingredients.map((stepIngredient: StepIngredientResponse): StepIngredient => stepIngredientAPIToClient(stepIngredient))
    }
};

const stepIngredientAPIToClient = (stepIngredient: StepIngredientResponse): StepIngredient => {
  return {
      id: stepIngredient.id,
      amount: stepIngredient.amount,
      condition: stepIngredient.condition,
      unit: stepIngredient.unit,
      name: stepIngredient.ingredient.name,
      description: stepIngredient.ingredient.description
  }
};