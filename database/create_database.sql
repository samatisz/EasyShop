USE sys;

# ---------------------------------------------------------------------- #
# Target DBMS:           MySQL                                           #
# Project name:          HearthShireHomeGoods                                        #
# ---------------------------------------------------------------------- #
DROP DATABASE IF EXISTS hearthshirehomegoods;

CREATE DATABASE IF NOT EXISTS hearthshirehomegoods;

USE hearthshirehomegoods;

# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #

CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    hashed_password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE profiles (
    user_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(200) NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE categories (
    category_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    PRIMARY KEY (category_id)
);

CREATE TABLE products (
    product_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT NOT NULL,
    description TEXT,
    color VARCHAR(20) DEFAULT NULL,
    image_url VARCHAR(200),
    stock INT NOT NULL DEFAULT 0,
    featured BOOL NOT NULL DEFAULT 0,
    PRIMARY KEY (product_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    date DATETIME NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    shipping_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE order_line_items (
    order_line_item_id INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    sales_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_line_item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- new tables
CREATE TABLE shopping_cart (
	user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


/*  INSERT Users  */
INSERT INTO users (username, hashed_password, role)
VALUES  ('user','$2a$10$NkufUPF3V8dEPSZeo1fzHe9ScBu.LOay9S3N32M84yuUM2OJYEJ/.','ROLE_USER'),
        ('admin','$2a$10$lfQi9jSfhZZhfS6/Kyzv3u3418IgnWXWDQDk7IbcwlCFPgxg9Iud2','ROLE_ADMIN'),
        ('george','$2a$10$lfQi9jSfhZZhfS6/Kyzv3u3418IgnWXWDQDk7IbcwlCFPgxg9Iud2','ROLE_USER');

/* INSERT Profiles */
INSERT INTO profiles (user_id, first_name, last_name, phone, email, address, city, state, zip)
VALUES  (1, 'Joe', 'Joesephus', '800-555-1234', 'joejoesephus@email.com', '789 Oak Avenue', 'Dallas', 'TX', '75051'),
        (2, 'Adam', 'Admamson', '800-555-1212', 'aaadamson@email.com', '456 Elm Street','Dallas','TX','75052'),
        (3, 'George', 'Jetson', '800-555-9876', 'george.jetson@email.com', '123 Birch Parkway','Dallas','TX','75051')     ;

/* INSERT Categories */
INSERT INTO categories (name, description)
VALUES  ('Home Decore and Kitchen', 'Even the smallest person can change the course of the furniture. We have everything to make your hobbit hole into a hobbit home.'),
		('Paint', 'Every hobit hole must look exquisite. We offer a wide variety of paint colors for all homes.'),
        ('Gardening Essentials', 'If there is one things hobbits love more than a good mug of ale and a fresh cheese wheel, it''s gardening.');

-- home & kitchen
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, color)
VALUES  ('Bilbo''s Bookshelf', 899.99, 1, 'The perfect place to house all of your reading material securely and fashionably.', 'bookshelf.jpg', 50, 1, 'Brown'),
        ('Cutting Board Set', 59.99, 1, 'Classic wooden cutting boards.', 'cuttingboards.jpg', 30, 0, 'Brown'),
        ('Decorative Mushroom Plates', 49.99, 1, 'A sophisticated set of plates to add a pop of color into your home.', 'decorativeplates.jpg', 40, 0, 'White'),
        ('Sage Bedding Set', 80.99, 1, 'Stay warm and comfy with this earth toned bed set.', 'deepgreenbedding.jpg', 25, 1, 'Green'),
        ('Desk with Shelf', 359.99, 1, 'A simple desk that has a connecting shelf. Perfect for displaying knick-knacks or books.', 'deskandshelf.jpg', 10, 0, 'Brown'),
        ('Ale Cup Set', 45.99, 1, 'Simple handcrafted ceramic cups.', 'drinkingcups.jpg', 30, 0, 'Tan'),
        ('Ceramic Eatery Set', 89.99, 1, 'Fine ceramic set of plates, bowls and mugs.', 'eateryset.jpg', 20, 0, 'Green'),
        ('Floating Planter Orbs', 29.99, 1, 'Small, rounded platers that can be mounted.', 'floatingplantballs.jpg', 50, 1, 'Clear'),
        ('Tea Cup Rack', 49.99, 1, 'A place for your mothers tea cup collection.', 'hangingcuprack.jpg', 15, 1, 'Charcoal'),
        ('Ben Fallowhide''s Mushroom Planters', 30.99, 1, 'A cute set of hanging mushrooms to settle your dear plants into.', 'hangingmushrooms.jpg', 25, 0, 'Orange'),
        ('Long Green Rug', 45.99, 1, 'A sophisticated and simple green rug to trip over when you walk down the hall.', 'longrug.jpg', 15, 1, 'Green'),
        ('Middle Earth Map Blanket', 50.99, 1, 'A warm woven blanket. Maybe you will finally learn geography like you promised your father you would.', 'middleearthblanket.jpg', 25, 0, 'Tan'),
        ('Hanging Vegetable Organizers', 18.99, 1, 'Simple woven bags to put onions, potatoes, and garlic into.', 'onionholder.jpg', 50, 0, 'Black'),
        ('Outlet Protector', 15.99, 1, 'A door protects us from the elements. Why can''t it protect us from an electrical shock?', 'outletprotector.jpg', 35, 1, 'Blue'),
        ('Rose Quilt', 79.99, 1, 'A soft quilt embroidered with roses.', 'rosequilt.jpg', 100, 1, 'Mint'),
        ('Round Green Rug', 35.99, 1, 'Another sophisticated and simple green rug to trip over in your den.', 'roundrug.jpg', 30, 1, 'Green'),
        ('Reversable Daisy-Green Bedding', 80.99, 1, 'A bedding set with a reversable comforter. Daisies on one side and a soft green on the other.', 'daisybedding.jpg', 10, 0, 'Green'),
        ('Reversable Blue Bedding', 80.99, 1, 'A bedding set with a reversable comforter. A floral pattern on one side and a soft blue on the other.', 'bluebedding.jpg', 50, 0, 'Blue'),
		('Hand Glazed Tea Set', 79.99, 1, 'Brew your favorite tea and serve it with this hand glazed set.', 'teaset.jpg', 30, 0, 'Green'),
        ('Handmade Tea Set', 100.99, 1, 'To brew the perfect cup of tea, you need to have the perfect tea set.', 'handmadeset.jpg', 40, 1, 'Tan'),
        ('Strawberry Tea Set', 35.99, 1, 'Do you remember the taste of stawberries? No? Well, you''ll remember what they look!', 'strawberryset.jpg', 30, 1, 'White');

-- paint
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, color)
VALUES  ('Blackest Black', 499.99, 2, '"Darkness must pass; a new day will come, and when the sun shines, it will shine out the clearer." - Unless you like darkness, in that case, paint your home with this dark shade.', 'blackestblack.jpg', 50, 0, 'Black'),
        ('Bombadil Blue', 899.99, 2, 'Old Tom Bombadil is a merry fellow! Bright blue his jacket is- And that is the color of this paint.', 'bluesky.jpg', 30, 0, 'Blue'),
        ('Poesy', 899.99, 2, 'A pink as light as poesy petals, if only it smelled as good.', 'blush.jpg', 100, 1, 'Pink'),
        ('Royal Purple', 1300.99, 2, 'A deep shade of purple that will make you feel as if you are a royal in your throne room and not just in the laundry room.', 'boromir.jpg', 20, 0, 'Purple'),
        ('Wine', 599.99, 2, 'A very beautiful and deep shade of red.', 'burgundypaint.jpg', 15, 1, 'Red'),
        ('Butter on Toast', 399.99, 2, 'This yellow reminds you of freshly toasted bread with the perfect amount of butter.', 'butteredtoast.jpg', 40, 0, 'Yellow'),
        ('Daisy', 349.99, 2, 'A gentle yellow to brighten any room of your home.', 'daisy.jpg', 10, 0, 'Yellow'),
        ('Shire Green', 879.99, 2, 'A rich and earthy shade of green that will remind one of the greenery in the Shire.', 'deepgreen.jpg', 75, 0, 'Green'),
        ('Edoras', 199.99, 2, 'Named after the captial of Rohan in honor of King Theoden.', 'earth.jpg', 25, 1, 'Brown'),
        ('Not All Those Who Wander Are Lost', 845.99, 2, 'For the adventurous.', 'eggplant.jpg', 50, 0, 'Purple'),
        ('Frodo Baggins', 399.99, 2, 'A blue that can be compared to the blue of Frodo Baggin''s eyes.', 'elvenblue.jpg', 5, 0, 'Blue'),
        ('Lothlorien', 229.99, 2, 'This color is just slightly less beautiful than the woodland realm it is named after.', 'evenstar.jpg', 20, 0, 'White'),
        ('Gandalf the Gray', 199.99, 2, 'Much like the wizard of the same name, this paint is gray.', 'gandalfthegrey.jpg', 30, 1, 'Gray'),
        ('Gandalf the White', 199.99, 2, 'Much like the wizard of the same name, this paint is white.', 'gandalfthewhite.jpg', 15, 0, 'White'),
        ('Ink', 129.99, 2, 'A shade of black paint.', 'ink.jpg', 25, 1, 'Black'),
        ('Fool of a Took', 399.99, 2, 'A very dark shade of green.', 'midnightgreen.jpg', 35, 1, 'Green'),
        ('Mordor', 199.99, 2, 'Mordor - the one place in Middle Earth we don''t want to see any closer, unless it is for the color of course.', 'mordor.jpg', 10, 0, 'Charcoal'),
        ('There And Back Again', 199.99, 2, 'A simple grayish-green shade. It reminds one of the calmness after a long journey.', 'morningdew.jpg', 50, 1, 'Mint'),
        ('Mount Doom', 189.99, 2, 'A natural and deep brown color that is actually not the color of mount doom at all.', 'mountdoom.jpg', 10, 0, 'Brown'),
        ('One Ring Gold', 1300.99, 2, 'One color to rule them all.', 'oneringgold.jpg', 50, 0, 'Yellow'),
		('Hearth Shire', 799.99, 2, 'A warm glowing orange to bring merriness and joy to your den.', 'orangepaint.jpg', 50, 1, 'Orange'),
        ('Brya the Dreamer', 449.99, 2, 'A shade of pink that will show off sophistication and femininity.', 'pennypink.jpg', 20, 1, 'Pink'),
        ('Abi Azalea', 449.99, 2, 'A soft shade of pink to remind one of freshly bloomed azalea''s', 'peosypink.jpg', 35, 0, 'Pink'),
        ('Rivendell Blue', 1100.99, 2, 'High-quality and very pigmented, perfect for the elven folk.', 'riverblue.jpg', 100, 1, 'Blue'),
        ('Smaug', 800.99, 2, 'A deep and royal shade of red.', 'rohirrimred.jpg', 30, 0, 'Red'),
        ('Tea Rose', 149.99, 2, 'A delicate and dainty pink like your mothers roses.', 'rose.jpg', 10, 0, 'Pink'),
        ('Grisom''s Green', 499.99, 2, 'A soft sage colored paint for your cozy sitting room.', 'sagegreen.jpg', 50, 1, 'Green'),
        ('Gondor', 1000.99, 2, 'Named after the ''White Tree'' in Gondor.', 'silvercloud.jpg', 40, 0, 'White'),
        ('Grey Havens', 199.99, 2, 'What can you see, on the horizon? Probably, this paint.', 'smeagol.jpg', 20, 0, 'Gray'),
        ('Amoni Sunset', 299.99, 2, 'This paint will make you feel like it is always golden hour.', 'softorangepaint.jpg', 30, 1, 'Orange'),
        ('Stone', 199.99, 2, 'Perfect for naturally colored homes and decor.', 'stone.jpg', 10, 0, 'Gray'),
        ('Minas Tirith', 299.99, 2, 'Our most popular shade of white. This color is regal and elegant, fitting for the King of Gondor and your house guests.', 'wanderer.jpg', 30, 1, 'White');


-- gardening
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, color)
VALUES  ('Anita''s Choice Gardening Gloves', 15.75, 3, 'The only pair of gloves that Anita found cute!', 'anitaschoicegloves.jpg', 500, 1, 'White'),
        ('Baby Potato Bulbs', 7.99, 3, 'Tiny little baby potatoes to grow in your garden. These were generously donated by Raymond the Wise.', 'babypotato.jpg', 10000, 0, NULL),
        ('Blue Bell Flower Seeds', 4.99, 3, 'Blue bell flowers to bring a pop of blue to your flower garden.', 'bluebell.jpg', 400, 1, 'Blue'),
        ('Cabbage Seeds', 3.99, 3, 'Cabbage is a very important ingredient in many meals, stop buying expensive and half-rotten heads of cabbage; grow your own!', 'cabbage.jpg', 250, 0, NULL),
        ('Calendula Flower Seeds', 4.99, 3, 'A bright and beautiful flower to add ot your garden.', 'calendula.jpg', 10, 1, 'Orange'),
        ('Aisha''s Colorful Carrot Seeds', 6.99, 3, 'Crisp and flavorful carrots that come in a variety of colors. The seeds come from Aisha Goodchild''s home garden.', 'carrot.jpg', 10, 0, NULL),
        ('Cauliflower Seeds', 4.75, 3, 'Grow your own tasty cauliflower! Make your great-aunt jealous with a tasty cauliflower pot-pie!', 'cauliflower.jpg', 20, 1, NULL),
        ('Chammomile Seeds', 5.75, 3, 'A perfect flower for your garden and they are great for homemade tea!', 'chammomile.jpg', 50, 1, NULL),
        ('Cinderella Pumpkin Seeds', 3.75, 3, 'Unfortunatley, you do not have a fairy god mother to turn these into carriages. They are still a wonderful addition to a home garden!', 'cinderellapumpkin.jpg', 15, 0, NULL),
        ('Daffodil Seeds', 3.975, 3, 'No garden is complete without daffodil''s.', 'daff.jpg', 25, 0, 'Yellow'),
        ('Pink Dahlia Seeds', 4.75, 3, 'A classy and sophisticated flower to show your neighbors that you have refined tastes.', 'dahlia.jpg', 50, 0, NULL),
        ('English Ivy Seeds', 10.75, 3, '"Every hobbit hole needs some english ivy." - Someone famous probably', 'englishivy.jpg', 35, 1, 'Green'),
        ('Green Gardening Gloves', 20.99, 3, 'Green colored gloves with a floral design.', 'greengloves.jpg', 25, 0, 'Green'),
        ('Jewel Sweet Potato Bulbs', 10.99, 3, 'A variety of sweet potato for all of you sweet tooth potato lovers.', 'sweetpotato.jpg', 50, 0, NULL),
        ('Lavender Seeds', 6.75, 3, 'A perfect flower for your garden and it is great for a homemade tea!', 'lavender.jpg', 10, 0, 'Purple'),
        ('Mint Seeds', 3.75, 3, 'Grow your own mint so you can stop stealing it from your neighbor.', 'mint.jpg', 20, 0, NULL),
        ('Mushroom Growing Kit', 20.99, 3, 'Grow many types of edible mushrooms with this starter kit.', 'mushroomgrowkit.jpg', 3500, 0, NULL),
        ('Haby''s Okra Seeds', 11.99, 3, 'These seeds come special from Miss Haby''s home garden.', 'okra.jpg', 30, 1, NULL),
        ('Parsley Seeds', 2.99, 3, 'Parsley makes every dish look fancy!', 'parsley.jpg', 25, 1, NULL),
        ('Pea Pods', 5.99, 3, 'Everyone needs to eat peas with their mashed potatoes and roast! Here is a way to make sure you always have some handy.', 'peas.jpg', 50, 0, NULL),
        ('Pink Tea Rose Seeds', 5.99, 3, 'Tea roses are elegant and make a garden have a pop of color without overpowering everything else.', 'pinktearose.jpg', 30, 1, 'Pink'),
        ('Russet Potato Bulbs', 4.99, 3, 'PO-TAY-TOES! Boil ''em mash ''em, stick ''em in a stew - A popular potato for all dishes!', 'russetpotato.jpg', 25, 0, NULL),
        ('Simbelmyne Seeds', 15.99, 3, 'These floswers come from Edoras and normally grow on the graves of fallen Rohirrim. We have developed a species that grows anywhere!', 'simbelmyne.jpg', 50, 1, 'White'),
        ('Thistle Seeds', 10.99, 3, 'Thistle are a gorgeous and vibrant plant, lovely for sitting in front of your fence.', 'thistle.jpg', 150, 1, 'Purple'),
        ('Beef Steak Tomato Seeds', 3.99, 3, 'The king of all tomatoes.', 'tomato.jpg', 25, 0, NULL),
        ('Stevenson''s Gardening Tool Set', 19.99, 3, 'The most important tools for any gardener. You can''t be Samwise the Brave, but you can have his gardening supplies', 'tools.jpg', 35, 0, 'Black'),
        ('White Button Mushroom Kit', 12.99, 3, 'This kit will help you grow specifically white button mushrooms.', 'whitebuttonmushrooms.jpg', 100, 0, NULL),
        ('Wagley''s Wooden Wheelbarrow', 49.99, 3, 'For hobbits that need to weed a lot and move around manuer and dirt.', 'wooden.jpg', 30, 1, 'Brown'),
        ('Yellow Onion Bulbs', 3.99, 3, 'According to our founder, yellow onions are the best onions.', 'yellowonion.jpg', 50, 1, NULL);

-- add shopping cart items
INSERT INTO shopping_cart (user_id, product_id, quantity)
VALUES  (3, 8, 1),
        (3, 10, 1);