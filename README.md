# Shopping-Cart
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

	Backend Development Progress — Shopping Cart API

	Completed Features

	Implemented the core shopping cart functionality using Ruby on Rails API and PostgreSQL.

	Cart creation: Create a guest shopping cart with a unique UUID token.

	Cart retrieval: Retrieve cart details, products, quantities, and subtotal using the cart token.

	Add products: Add products to the cart and increase the quantity when the same product is added again.

	Update quantity: Update the quantity of an existing cart item.

	Remove products: Remove individual items from the cart.

	Stock validation: Prevent customers from adding quantities greater than the available stock.

	Error handling: Handle invalid cart tokens, nonexistent products, and invalid quantities with appropriate HTTP status codes.

	Subtotal calculation: Calculate line totals and cart subtotal using decimal arithmetic.

	Empty cart handling: Return an empty items array and zero subtotal when the cart contains no items.

	Testing

	Manually verified the API endpoints and validation scenarios using Postman.

	Tested scenarios include:

	Successful cart creation and retrieval.

	Adding, updating, and deleting cart items.

	Zero and negative quantities.

	Invalid product IDs and cart tokens.

	Quantity exceeding available stock.

	Correct line totals and subtotal calculations.

	Empty cart response.

	Current Status

	Backend core functionality completed and manually verified through Postman.

	Technology Stack

	Backend: Ruby on Rails API

	Database: PostgreSQL

	API testing: Postman

	Version control: Git and GitHub

	Next Phase

	Frontend development using HTML, CSS, and JavaScript, followed by integration with the Rails API.


* ...
