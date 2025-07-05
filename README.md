

The Supplier Management component handles all supplier-side operations within the inventory system. Each supplier logs in to a personalized dashboard that displays only the items they supply. Products are sorted by expiry date using Merge Sort to ensure that items nearing expiry appear at the top of the list.

Products that are due to expire within seven days are flagged with a red warning alert to notify the supplier. Suppliers can efficiently manage their stock by adding new items, editing expiry dates, and updating their personal account credentials. Product removal uses a stack-based Last In First Out (LIFO) approach, allowing the most recently added items to be removed quickly and easily when needed.

Features and CRUD Operations

Create: Suppliers can add new items by entering details such as category, type, price, quantity, supply date, and expiry date.

Read: All supplied items are displayed sorted by expiry date using Merge Sort. Items expiring within seven days are highlighted with a red warning alert for immediate attention.

Update: Suppliers can modify item expiry dates and personal account details such as passwords.

Delete: The most recently added item can be deleted using a stack-based LIFO method, supporting efficient error handling and stock management.

How to Use

Login to your supplier account. View your personalized dashboard with your supplied items sorted by expiry date. Add, update, or remove items as needed using the available options. Monitor warnings for items approaching expiry within seven days. Update your account credentials securely anytime.

Technologies Used

Sorting algorithm used is Merge Sort. Data structure for deletion is Stack implementing LIFO. (Add any frontend or backend frameworks you used here if needed.)
