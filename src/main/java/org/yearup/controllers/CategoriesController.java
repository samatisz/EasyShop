package org.yearup.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.yearup.data.CategoryDao;
import org.yearup.data.ProductDao;
import org.yearup.models.Category;
import org.yearup.models.Product;

import java.util.List;

// http://localhost:8080/categories

@RestController
@CrossOrigin
public class CategoriesController {
    private final CategoryDao categoryDao;
    private final ProductDao productDao;

    @Autowired
    public CategoriesController(CategoryDao categoryDao, ProductDao productDao) {
        this.categoryDao = categoryDao;
        this.productDao = productDao;
    }

    @RequestMapping(path = "/categories", method = RequestMethod.GET)
    public List<Category> getAllCategories() {
        List<Category> categoryList = categoryDao.getAllCategories();
        return categoryList;
    }

    @RequestMapping(path = "/categories/{categoryId}", method = RequestMethod.GET)
    public Category getCategoryById(@PathVariable int idNumber) {
        return categoryDao.getById(idNumber);
    }

    //TODO - add the url path
    // https://localhost:8080/categories/1/products
    @GetMapping("{categoryId}/products")
    public List<Product> getProductsById(@PathVariable int categoryId) {
        return getProductsById(categoryId);
    }

    //TODO - add annotation to ensure that only an ADMIN can call this function
    @RequestMapping(path = "/categories", method = RequestMethod.POST)
    @ResponseStatus(value = HttpStatus.CREATED)
    public Category addCategory(@RequestBody Category category) {
        return categoryDao.insert(category);
    }

    //TODO - add the url path - must include the categoryId
    // add annotation to ensure that only an ADMIN can call this function
    @RequestMapping(path = "/categories/{categoryId}", method = RequestMethod.PUT)
    public void updateCategory(@PathVariable int categoryId, @RequestBody Category category) {
        categoryDao.update(categoryId, category);
    }


    //TODO - add the url path - must include the categoryId
    // add annotation to ensure that only an ADMIN can call this function
    @RequestMapping(path = "/categories/{categoryId}", method = RequestMethod.DELETE)
    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    public void deleteCategory(@PathVariable int id) {
        categoryDao.delete(id);
    }
}
