import '../../models/user_model.dart';
import '../../models/post_model.dart';
import '../../models/recipe_model.dart';
import '../../models/ingredient_model.dart';
import '../../models/comment_model.dart';
import '../../models/short_video_model.dart';

class MockData {
  // Chefs
  static final UserModel chefArjun = UserModel(
    id: 'c1',
    name: 'Chef Arjun',
    handle: '@chefarjun',
    profileImage: 'https://images.unsplash.com/photo-1577219491135-ce391730fb2c?w=400&auto=format&fit=crop',
    bio: 'Executive Chef at Coastal Spice. Master of South Indian coastal gastronomy & fusion flavors.',
    role: 'Executive Chef',
    location: 'Kochi, Kerala',
    isVerified: true,
    followersCount: 12420,
    followingCount: 248,
    totalRecipesCount: 84,
    totalLikesCount: 84250,
    specializations: ['Kerala Cuisine', 'Seafood', 'Coastal Fusion', 'Spice Blends'],
    rating: 4.9,
  );

  static final UserModel chefPriya = UserModel(
    id: 'c2',
    name: 'Chef Priya Roy',
    handle: '@priyacooking',
    profileImage: 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=400&auto=format&fit=crop',
    bio: 'Pastry Architect & Artisan Baker. Passionate about authentic desserts & modern presentation.',
    role: 'Master Pastry Chef',
    location: 'Mumbai, Maharashtra',
    isVerified: true,
    followersCount: 28900,
    followingCount: 312,
    totalRecipesCount: 112,
    totalLikesCount: 194000,
    specializations: ['Artisan Baking', 'Pastry Art', 'Indian Sweets', 'Plating'],
    rating: 5.0,
  );

  static final UserModel chefMarco = UserModel(
    id: 'c3',
    name: 'Chef Marco Rossi',
    handle: '@marcorossi',
    profileImage: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&auto=format&fit=crop',
    bio: 'Traditional Italian Chef bringing authentic homemade pasta and Woodfire pizzas to your kitchen.',
    role: 'Head Culinary Director',
    location: 'Rome, Italy',
    isVerified: true,
    followersCount: 45100,
    followingCount: 190,
    totalRecipesCount: 145,
    totalLikesCount: 310500,
    specializations: ['Handmade Pasta', 'Neapolitan Pizza', 'Risotto', 'Italian Sauces'],
    rating: 4.9,
  );

  // Recipes
  static final RecipeModel recipeKeralaChickenCurry = RecipeModel(
    id: 'r1',
    title: 'Kerala Chicken Curry (Nadan Kozhi Curry)',
    description: 'A rich, roasted coconut-based chicken curry infused with freshly roasted spices, curry leaves, and toasted coconut oil.',
    coverImage: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=800&auto=format&fit=crop',
    author: chefArjun,
    cuisine: 'Kerala Indian',
    category: 'Main Course',
    difficulty: 'Medium',
    prepTimeMinutes: 15,
    cookTimeMinutes: 30,
    servings: 4,
    calories: 480,
    rating: 4.9,
    reviewsCount: 184,
    dietaryOptions: ['Gluten Free', 'Halal', 'High Protein'],
    likesCount: 2420,
    savesCount: 890,
    isLiked: true,
    isSaved: true,
    ingredients: [
      IngredientModel(name: 'Chicken (Bone-in)', quantity: '750', unit: 'g'),
      IngredientModel(name: 'Onions (Thinly sliced)', quantity: '3', unit: 'pcs'),
      IngredientModel(name: 'Grated Coconut', quantity: '1', unit: 'cup'),
      IngredientModel(name: 'Thick Coconut Milk', quantity: '200', unit: 'ml'),
      IngredientModel(name: 'Ginger-Garlic Paste', quantity: '2', unit: 'tbsp'),
      IngredientModel(name: 'Kashmiri Chili Powder', quantity: '2', unit: 'tbsp'),
      IngredientModel(name: 'Coriander Powder', quantity: '1.5', unit: 'tbsp'),
      IngredientModel(name: 'Garam Masala', quantity: '1', unit: 'tsp'),
      IngredientModel(name: 'Curry Leaves', quantity: '3', unit: 'sprigs'),
      IngredientModel(name: 'Coconut Oil', quantity: '3', unit: 'tbsp'),
    ],
    steps: [
      RecipeStepModel(
        stepNumber: 1,
        title: 'Roast Coconut & Spices',
        instruction: 'In a pan over medium heat, dry roast grated coconut with curry leaves until golden brown. Add coriander and chili powder. Cool and grind into a smooth paste with little water.',
        timerMinutes: 8,
      ),
      RecipeStepModel(
        stepNumber: 2,
        title: 'Sauté Aromatics',
        instruction: 'Heat coconut oil in a clay pot or heavy pan. Sauté sliced onions, ginger-garlic paste, and green chilies until dark golden brown.',
        timerMinutes: 10,
      ),
      RecipeStepModel(
        stepNumber: 3,
        title: 'Cook Chicken & Simmer',
        instruction: 'Add chicken pieces, ground coconut paste, and 1 cup of warm water. Cover and simmer on low heat until chicken is tender.',
        timerMinutes: 20,
      ),
      RecipeStepModel(
        stepNumber: 4,
        title: 'Finish with Coconut Milk & Tempering',
        instruction: 'Stir in thick coconut milk, turn off heat, and temper with mustard seeds and curry leaves fried in coconut oil.',
        timerMinutes: 2,
      ),
    ],
  );

  static final RecipeModel recipeButterChicken = RecipeModel(
    id: 'r2',
    title: 'Velvety Murgh Makhani (Butter Chicken)',
    description: 'Tender tandoori-marinated chicken cooked in a smooth tomato, cream, and butter sauce with aromatic Kasuri Methi.',
    coverImage: 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=800&auto=format&fit=crop',
    author: chefPriya,
    cuisine: 'North Indian',
    category: 'Main Course',
    difficulty: 'Medium',
    prepTimeMinutes: 20,
    cookTimeMinutes: 35,
    servings: 4,
    calories: 620,
    rating: 5.0,
    reviewsCount: 340,
    dietaryOptions: ['Gluten Free', 'Rich & Comfort'],
    likesCount: 3890,
    savesCount: 1450,
    ingredients: [
      IngredientModel(name: 'Boneless Chicken Thighs', quantity: '600', unit: 'g'),
      IngredientModel(name: 'Greek Yogurt', quantity: '0.5', unit: 'cup'),
      IngredientModel(name: 'Butter', quantity: '50', unit: 'g'),
      IngredientModel(name: 'Tomato Puree', quantity: '2', unit: 'cups'),
      IngredientModel(name: 'Heavy Cream', quantity: '100', unit: 'ml'),
      IngredientModel(name: 'Cashew Paste', quantity: '3', unit: 'tbsp'),
      IngredientModel(name: 'Kasuri Methi', quantity: '1', unit: 'tbsp'),
    ],
    steps: [
      RecipeStepModel(
        stepNumber: 1,
        title: 'Marinate & Sear',
        instruction: 'Marinate chicken in yogurt, lemon, and spices for 2 hours. Sear on high heat in a skillet until charred.',
        timerMinutes: 12,
      ),
      RecipeStepModel(
        stepNumber: 2,
        title: 'Prepare Velvet Gravy',
        instruction: 'Simmer tomato puree with cashews, butter, and spices. Strain sauce for ultimate silkiness.',
        timerMinutes: 15,
      ),
      RecipeStepModel(
        stepNumber: 3,
        title: 'Combine & Finish',
        instruction: 'Add seared chicken into gravy, finish with heavy cream and crushed Kasuri Methi.',
        timerMinutes: 8,
      ),
    ],
  );

  static final RecipeModel recipeHandmadePasta = RecipeModel(
    id: 'r3',
    title: 'Authentic Fettuccine Alfredo with Truffle Butter',
    description: 'Fresh egg pasta tossed in 24-month Parmigiano-Reggiano cream and finished with fresh black truffle oil.',
    coverImage: 'https://images.unsplash.com/photo-1621996346565-e3d5d6281270?w=800&auto=format&fit=crop',
    author: chefMarco,
    cuisine: 'Italian',
    category: 'Pasta',
    difficulty: 'Easy',
    prepTimeMinutes: 15,
    cookTimeMinutes: 10,
    servings: 2,
    calories: 520,
    rating: 4.8,
    reviewsCount: 95,
    dietaryOptions: ['Vegetarian'],
    likesCount: 1820,
    savesCount: 630,
    ingredients: [
      IngredientModel(name: 'Fresh Fettuccine', quantity: '250', unit: 'g'),
      IngredientModel(name: 'Unsalted Butter', quantity: '60', unit: 'g'),
      IngredientModel(name: 'Parmigiano-Reggiano', quantity: '100', unit: 'g'),
      IngredientModel(name: 'Pasta Water', quantity: '0.5', unit: 'cup'),
      IngredientModel(name: 'Truffle Oil', quantity: '1', unit: 'tsp'),
    ],
    steps: [
      RecipeStepModel(
        stepNumber: 1,
        title: 'Boil Pasta',
        instruction: 'Cook fresh pasta in salted boiling water for 3 minutes until al dente.',
        timerMinutes: 3,
      ),
      RecipeStepModel(
        stepNumber: 2,
        title: 'Emulsify Sauce',
        instruction: 'Melt butter with pasta water and finely grated parmesan over gentle heat to form an emulsion.',
        timerMinutes: 4,
      ),
      RecipeStepModel(
        stepNumber: 3,
        title: 'Plate & Serve',
        instruction: 'Toss fettuccine in pan, plate immediately, and drizzle with truffle oil.',
        timerMinutes: 2,
      ),
    ],
  );

  // Posts Feed
  static final List<PostModel> posts = [
    PostModel(
      id: 'p1',
      author: chefArjun,
      location: 'Kochi, Kerala',
      foodImage: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=800&auto=format&fit=crop',
      foodName: 'Kerala Traditional Chicken Curry',
      description: 'Slow-cooked roasted coconut chicken curry brewed in traditional clay pots. Pairs perfectly with appams or steamed Kerala Matta rice! 🥥🔥',
      prepTimeMinutes: 45,
      difficulty: 'Medium',
      cuisine: 'Kerala Indian',
      likesCount: 2420,
      commentsCount: 183,
      savesCount: 421,
      isLiked: true,
      isSaved: false,
      recipe: recipeKeralaChickenCurry,
      timeAgo: '2 hours ago',
    ),
    PostModel(
      id: 'p2',
      author: chefPriya,
      location: 'Mumbai, India',
      foodImage: 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=800&auto=format&fit=crop',
      foodName: 'Velvety Murgh Makhani',
      description: 'The secret to silky butter chicken isn’t more butter—it’s double-straining the tomato cashew reduction and slow-roasting the spices! ✨',
      prepTimeMinutes: 55,
      difficulty: 'Medium',
      cuisine: 'North Indian',
      likesCount: 3890,
      commentsCount: 240,
      savesCount: 910,
      isLiked: false,
      isSaved: true,
      recipe: recipeButterChicken,
      timeAgo: '5 hours ago',
    ),
    PostModel(
      id: 'p3',
      author: chefMarco,
      location: 'Rome, Italy',
      foodImage: 'https://images.unsplash.com/photo-1621996346565-e3d5d6281270?w=800&auto=format&fit=crop',
      foodName: 'Truffle Fettuccine Alfredo',
      description: 'Simple ingredients done right. 0km fresh egg yolk fettuccine tossed with aged Parmigiano Reggiano and truffle infusion. 🍝',
      prepTimeMinutes: 25,
      difficulty: 'Easy',
      cuisine: 'Italian',
      likesCount: 1820,
      commentsCount: 94,
      savesCount: 630,
      isLiked: true,
      isSaved: true,
      recipe: recipeHandmadePasta,
      timeAgo: '1 day ago',
    ),
  ];

  // Comments
  static final List<CommentModel> sampleComments = [
    CommentModel(
      id: 'cm1',
      authorName: 'Rahul Verma',
      authorImage: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&auto=format&fit=crop',
      text: 'Tried this recipe yesterday for dinner! The roasted coconut aroma was absolutely unreal 🔥',
      timeAgo: '1 hour ago',
      likesCount: 14,
      isLiked: true,
    ),
    CommentModel(
      id: 'cm2',
      authorName: 'Anu Sharma',
      authorImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&auto=format&fit=crop',
      text: 'How much coconut milk should I use if I want a thicker gravy?',
      timeAgo: '35 mins ago',
      likesCount: 4,
    ),
    CommentModel(
      id: 'cm3',
      authorName: 'Chef Priya Roy',
      authorImage: 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=200&auto=format&fit=crop',
      text: 'Stunning presentation Chef Arjun! Love the claypot tempering technique 👌',
      timeAgo: '15 mins ago',
      likesCount: 28,
      isLiked: true,
    ),
  ];

  // Short Cooking Videos
  static final List<ShortVideoModel> cookingShorts = [
    ShortVideoModel(
      id: 'v1',
      author: chefArjun,
      title: 'How to Roast Coconut for Nadan Curries 🥥',
      description: 'Master the dark golden roast without burning the spices! Key tip: Low flame & continuous stirring.',
      thumbnailUrl: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=600&auto=format&fit=crop',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      likesCount: 14500,
      commentsCount: 420,
      sharesCount: 1200,
      recipeId: 'r1',
    ),
    ShortVideoModel(
      id: 'v2',
      author: chefPriya,
      title: '3 Pastry Knife Tricks Every Chef Needs 🔪',
      description: 'Clean cuts on delicate cakes every single time. Dip in hot water and wipe dry between slices!',
      thumbnailUrl: 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=600&auto=format&fit=crop',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      likesCount: 28900,
      commentsCount: 890,
      sharesCount: 3400,
      recipeId: 'r2',
    ),
    ShortVideoModel(
      id: 'v3',
      author: chefMarco,
      title: 'The Golden Pasta Water Secret 🍝',
      description: 'Why you should NEVER drain pasta water into the sink. The secret emulsion binder!',
      thumbnailUrl: 'https://images.unsplash.com/photo-1621996346565-e3d5d6281270?w=600&auto=format&fit=crop',
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      likesCount: 39100,
      commentsCount: 1120,
      sharesCount: 5600,
      recipeId: 'r3',
    ),
  ];

  // Saved Collections
  static final List<Map<String, dynamic>> savedCollections = [
    {
      'title': 'Kerala Recipes',
      'count': 12,
      'image': 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=400&auto=format&fit=crop',
    },
    {
      'title': 'Weekend Dinner',
      'count': 8,
      'image': 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=400&auto=format&fit=crop',
    },
    {
      'title': 'Quick < 30 Min',
      'count': 15,
      'image': 'https://images.unsplash.com/photo-1621996346565-e3d5d6281270?w=400&auto=format&fit=crop',
    },
    {
      'title': 'Desserts & Sweets',
      'count': 6,
      'image': 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400&auto=format&fit=crop',
    },
  ];
}
