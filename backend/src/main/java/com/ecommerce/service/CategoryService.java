package com.ecommerce.service;

import com.ecommerce.dto.CategoryDTO;
import java.util.List;
import java.util.UUID;

public interface CategoryService {
    List<CategoryDTO> getAllCategories();

    CategoryDTO createCategory(CategoryDTO categoryDTO);

    CategoryDTO updateCategory(UUID id, CategoryDTO categoryDTO);

    void deleteCategory(UUID id);
}
