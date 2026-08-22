import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/ingredient_model.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: 'Kerala Chicken Curry');
  final _descriptionController = TextEditingController(
    text: 'Rich coconut-based chicken curry infused with freshly roasted spices and curry leaves.',
  );
  
  String _cuisine = 'Kerala';
  String _category = 'Main Course';
  String _difficulty = 'Medium';
  int _prepTime = 15;
  int _cookTime = 30;
  int _servings = 4;

  final List<IngredientModel> _ingredients = [
    IngredientModel(name: 'Chicken', quantity: '500', unit: 'g'),
    IngredientModel(name: 'Onion', quantity: '2', unit: 'pcs'),
    IngredientModel(name: 'Coconut Milk', quantity: '250', unit: 'ml'),
  ];

  final List<RecipeStepModel> _steps = [
    RecipeStepModel(
      stepNumber: 1,
      title: 'Prepare Spices',
      instruction: 'Heat oil in a large pan and roast spices until aromatic.',
      timerMinutes: 5,
    ),
  ];

  void _addIngredient() {
    setState(() {
      _ingredients.add(IngredientModel(name: '', quantity: '1', unit: 'pcs'));
    });
  }

  void _addStep() {
    setState(() {
      _steps.add(
        RecipeStepModel(
          stepNumber: _steps.length + 1,
          title: 'Step ${_steps.length + 1}',
          instruction: '',
        ),
      );
    });
  }

  void _publishRecipe() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎉 Recipe Published Successfully! Available in Feed.'),
        backgroundColor: AppColors.accentTeal,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Publish New Recipe',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Draft saved locally.')),
              );
            },
            child: const Text('Save Draft', style: TextStyle(color: AppColors.textSecondary)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Cover Photo Upload Box
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border, style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_a_photo_outlined, size: 42, color: AppColors.primary),
                  SizedBox(height: 8),
                  Text(
                    'Upload High Res Recipe Cover Photo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    'PNG, JPG up to 10MB',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Basic Information
            _buildSectionHeader('Recipe Information'),
            const SizedBox(height: 12),

            _buildTextField('Recipe Name', _titleController, 'e.g. Kerala Chicken Curry'),
            const SizedBox(height: 14),
            _buildTextField('Description', _descriptionController, 'Brief recipe backstory...', maxLines: 3),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(child: _buildDropdown('Cuisine', _cuisine, ['Kerala', 'Italian', 'Mexican', 'Chinese'], (v) => setState(() => _cuisine = v!))),
                const SizedBox(width: 12),
                Expanded(child: _buildDropdown('Difficulty', _difficulty, ['Easy', 'Medium', 'Hard'], (v) => setState(() => _difficulty = v!))),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(child: _buildNumberInput('Prep (min)', _prepTime, (v) => setState(() => _prepTime = v))),
                const SizedBox(width: 10),
                Expanded(child: _buildNumberInput('Cook (min)', _cookTime, (v) => setState(() => _cookTime = v))),
                const SizedBox(width: 10),
                Expanded(child: _buildNumberInput('Servings', _servings, (v) => setState(() => _servings = v))),
              ],
            ),

            const SizedBox(height: 28),

            // Ingredients Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionHeader('Ingredients'),
                TextButton.icon(
                  onPressed: _addIngredient,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('+ ADD INGREDIENT'),
                  style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _ingredients.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          initialValue: _ingredients[index].name,
                          decoration: const InputDecoration(hintText: 'Item (e.g. Chicken)', isDense: true),
                          onChanged: (v) => _ingredients[index] = IngredientModel(name: v, quantity: _ingredients[index].quantity, unit: _ingredients[index].unit),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: _ingredients[index].quantity,
                          decoration: const InputDecoration(hintText: 'Qty', isDense: true),
                          onChanged: (v) => _ingredients[index] = IngredientModel(name: _ingredients[index].name, quantity: v, unit: _ingredients[index].unit),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: _ingredients[index].unit,
                          decoration: const InputDecoration(hintText: 'Unit', isDense: true),
                          onChanged: (v) => _ingredients[index] = IngredientModel(name: _ingredients[index].name, quantity: _ingredients[index].quantity, unit: v),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                        onPressed: () {
                          setState(() => _ingredients.removeAt(index));
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            // Cooking Steps Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionHeader('Cooking Steps'),
                TextButton.icon(
                  onPressed: _addStep,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('+ ADD STEP'),
                  style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Step ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: _steps[index].instruction,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          hintText: 'Detail instruction step...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // Publish Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _publishRecipe,
                child: const Text(
                  'PUBLISH RECIPE NOW',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberInput(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(onTap: () => onChanged(value > 1 ? value - 1 : 1), child: const Icon(Icons.remove, size: 16)),
              Text('$value', style: const TextStyle(fontWeight: FontWeight.bold)),
              InkWell(onTap: () => onChanged(value + 1), child: const Icon(Icons.add, size: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
