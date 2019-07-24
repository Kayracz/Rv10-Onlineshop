## TODO:
### Config
Set the right cloud name in config/cloudinary.yml

### Cart
Add/Reduce one, not working.
Delete not working.

### Refactor Views men/womed/products
At first glance it seems that all of these views can be combined
into a single one or at least move huge chucks of them to a 
partial view (easy maintenace).

### Refactor product/size
Right now *size* is a string hand glued to the sizes table. It'll be better
to use associations.

## Changes
### Added config/cloudinary
This change was required to see products on most pages.

### Added seed data
This allows us to test the website without actually
improting producs.

### Changed the seed file
Now we can run the rake db:seed several times without any issues.


## Open questions
### Why not use a category object instead of a string?
class Product
    belongs_to :category
end
This variant could allow the user to add/rename categories
without changing the code and without updates on the products
table.

### On the nav menu, sales points to a view that 
shows all products. Is that correct?

### Why each product has two different sizes?

