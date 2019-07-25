### DONE
* Add select option for different sizes/stock.
* Show a hint for sizes out of stock. (Simil Markova.)
* Update stock as the user adds/removes products from the cart.
* Fix Add/Reduce. Is not working.
* Fix Delete from cart. Is not working.
* Add cloudinary config file.
* Seed products, stock, and sizes.

### TODO:
**Config**
* Don't forget to set the right cloud name in config/cloudinary.yml

### Sugestions
* Refactor Views men/womed/products

Maybe I'm missing something obvious, but at first glance,
it seems that all of these views can be combined into 
a single one. Or at least, move huge chucks of them to a 
partial view (easy maintenace).

### Open questions
* Why not use a category object instead of a string?

Something like
class Product
    belongs_to :category
end

This variant could allow the admin to add/rename categories
without changing the code *and* without updatig the products
table.

* On the nav menu, sales points to a view that shows all products.

Is that by design?

* Why products have two different sizes?

