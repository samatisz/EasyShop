package org.yearup.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.yearup.data.ProductDao;
import org.yearup.data.ShoppingCartDao;
import org.yearup.data.UserDao;
import org.yearup.models.ShoppingCart;
import org.yearup.models.User;

import java.security.Principal;

//// only logged in users should have access to these actions
//@RestController
//@RequestMapping("cart")
//@PreAuthorize("isAuthenticated()")
//@CrossOrigin
public class ShoppingCartController { // a shopping cart requires
}
//    private final ShoppingCartDao shoppingCartDao;
//    private final UserDao userDao;
//    private final ProductDao productDao;
//
//    @Autowired
//    public ShoppingCartController(ShoppingCartDao shoppingCartDao, UserDao userDao, ProductDao productDao) {
//        this.shoppingCartDao = shoppingCartDao;
//        this.userDao = userDao;
//        this.productDao = productDao;
//    }
//
//    // each method in this controller requires a Principal object as a parameter
//    @GetMapping
//    @PreAuthorize("hasRole('Role_USER')")
//    public ShoppingCart getCart(Principal principal) {
//        try
//        {
//            // get the currently logged in username
//            String userName = principal.getName();
//            // find database user by userId
//            User user = userDao.getByUserName(userName);
//            int userId = user.getId();
//
//           ShoppingCart cart = shoppingCartDao.getByUserId(userId);
//           return cart;
//        }
//        catch(Exception e)
//        {
//            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Oops... our bad.");
//        }
//    }
//
//   @PostMapping("products/{id}")
//   public ShoppingCart addToCart(@PathVariable int id, Principal principal) {
//       try {
//           String username = principal.getName();
//           User user = userDao.getByUserName(username);
//           int userId = user.getId();
//           return shoppingCartDao.addItem(userId, id);
//       } catch (Exception e) {
//           throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Oops... our bad.");
//       }
//   }
//
//
////    // TODO - add a PUT method to update an existing product in the cart - the url should be
////    //  https://localhost:8080/cart/products/15 (15 is the productId to be updated)
////    //  the BODY should be a ShoppingCartItem - quantity is the only value that will be updated
////
////   public void  ShoppingCart() {
////        return null;
////    }
////
////
//// //TODO - add a DELETE method to clear all products from the current users cart
////  //https://localhost:8080/cart
////
////   public void ShoppingCart() {
////        return null;
////    }
//
//}
