# MediHome

MediHome is a PHP + MySQL healthcare-products storefront for local XAMPP development.

## Setup
1. Extract the project folder to `C:\xampp\htdocs\MediHome`.
2. Start Apache and MySQL in XAMPP.
3. Open phpMyAdmin and import `database/medihome.sql` into a fresh setup.
4. Check `config.php` and set the MySQL port/credentials to match your local XAMPP configuration.
5. Visit `http://localhost/MediHome/`.

**Important:** `database/medihome.sql` recreates the project tables and may erase existing users, orders, and catalogue data. Back up the database before importing again. If you already have MediHome working, update the project files without importing the SQL again.

## Storefront features
- Responsive homepage hero slider and category banners
- Horizontal, touch-friendly product shelves with smooth scrolling
- Animated product/category cards and responsive action buttons
- Product catalogue, category browsing, cart and checkout
- Customer registration/login, account/order history and order tracking
- Admin dashboard, medicine inventory and order status management
- Cash on Delivery (COD) is the only checkout payment method
- Social links in the footer (currently generic platform links; replace with official brand profiles if available)

## Notes
- Product images use local SVG artwork and external product-image URLs in the SQL seed data. External images may fail if the source blocks hotlinking; verify product details and image usage rights.
- This local project does not process online payments. It is not connected to a pharmacy, prescription verification service, delivery provider, or real fulfilment workflow. Do not use it to sell or dispense real medicines without appropriate legal, clinical, privacy, payment, and fulfilment safeguards.
- All PHP files passed `php -l` syntax checks. Browser/database end-to-end testing has not been performed in this package build.
