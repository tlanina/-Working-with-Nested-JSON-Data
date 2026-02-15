# Flipkart Fashion Products - JSON Data Parsing & Analysis 

** For this assignment, the Flipkart Fashion Products dataset was selected. **

Flipkart is the largest E-commerce website based in India. The pre-crawled dataset has more than 5.7 million records

The dataset meets all requirements:

- Stored in JSON format
- Contains nested structures
- product_details is array of maps (key-value pairs)

***Size is 82 mb***

The dataset contains product information such asurl, name, _id, crawled_at, selling_price, original_price, discount, brand, seller_name, seller_rating, images, 
product_details, pid, description, out_of_stock, flipkart_assured, breadcrumbs

## Data Analysis Using Window Functions ##

**Insight 1. Product Availability Percentage**

*Result:*
Out of approximately 30,000 products, only 1,742 (5.81%) are out of stock.

*Interpretation:*
The platform maintains a high level of product availability, indicating efficient inventory management.

**Insight 2. Top-3 Most Expensive Brands per Category**

*What this analysis does:*
- Calculates average price per brand within each category
- Ranks brands inside each category
- Identifies the top-3 premium brands

*Interpretation:*
This analysis highlights premium brands dominating each product category based on pricing.
