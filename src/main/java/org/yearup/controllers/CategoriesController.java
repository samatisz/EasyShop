package org.yearup.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.yearup.data.CategoryDao;
import org.yearup.data.ProductDao;
import org.yearup.models.Category;
import org.yearup.models.Product;

import java.util.List;

// http://localhost:8080/categories

@RestController
@RequestMapping("categories")
@CrossOrigin
public class CategoriesController {
    private final CategoryDao categoryDao;
    private final ProductDao productDao;

    @Autowired
    public CategoriesController(CategoryDao categoryDao, ProductDao productDao) {
        this.categoryDao = categoryDao;
        this.productDao = productDao;
    }

    @GetMapping("")
    @PreAuthorize("permitAll()")
    public List<Category> getAllCategories() { //TODO need to fix this one i think????
        List<Category> categoryList = categoryDao.getAllCategories();
        return categoryList;
    }

    @GetMapping("")
    public Category getCategoryById(@PathVariable int idNumber) {
        return categoryDao.getById(idNumber);
    }

    @GetMapping("{categoryId}/products")
    public List<Product> getProductsById(@PathVariable int categoryId) {
        return getProductsById(categoryId);
    }

    @GetMapping("")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @ResponseStatus(value = HttpStatus.CREATED)
    public Category addCategory(@RequestBody Category category) {
        return categoryDao.create(category);
    }


    @GetMapping("{categoryId}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public void updateCategory(@PathVariable int categoryId, @RequestBody Category category) {
        categoryDao.update(categoryId, category);
    }
    
    @GetMapping("{categoryId}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public void deleteCategory(@PathVariable int id) {
        categoryDao.delete(id);
    }
}
