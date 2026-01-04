package com.ecommerce.service.impl;

import com.ecommerce.dto.CategoryDTO;
import com.ecommerce.entity.Category;
import com.ecommerce.exception.ResourceNotFoundException;
import com.ecommerce.repository.CategoryRepository;
import com.ecommerce.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.CacheEvict;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    @Cacheable(value = "categories")
    public List<CategoryDTO> getAllCategories() {
        return categoryRepository.findAll().stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    @Override
    @CacheEvict(value = "categories", allEntries = true)
    public CategoryDTO createCategory(CategoryDTO categoryDTO) {
        Category category = new Category();
        category.setName(categoryDTO.getName());
        category.setDescription(categoryDTO.getDescription());
        return mapToDTO(categoryRepository.save(category));
    }

    @Override
    @Transactional // Added @Transactional annotation
    @CacheEvict(value = "categories", allEntries = true)
    public CategoryDTO updateCategory(UUID id, CategoryDTO categoryDTO) {
        Category category = categoryRepository.findById(java.util.Objects.requireNonNull(id))
                .orElseThrow(() -> new ResourceNotFoundException("Category not found"));

        category.setName(categoryDTO.getName());
        category.setDescription(categoryDTO.getDescription());

        return mapToDTO(categoryRepository.save(category));
    }

    @Override
    @CacheEvict(value = "categories", allEntries = true)
    public void deleteCategory(UUID id) {
        if (!categoryRepository.existsById(java.util.Objects.requireNonNull(id))) {
            throw new ResourceNotFoundException("Category not found");
        }
        categoryRepository.deleteById(java.util.Objects.requireNonNull(id));
    }

    private CategoryDTO mapToDTO(Category category) {
        CategoryDTO dto = new CategoryDTO();
        dto.setId(category.getId());
        dto.setName(category.getName());
        dto.setDescription(category.getDescription());
        return dto;
    }
}
