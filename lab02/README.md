#  Currency Exchange Rate Script (`currency_exchange_rate.py`)

This Python script interacts with the local exchange rate service API to fetch and log currency conversion rates for a specific date.

##  How to Install Dependencies

The script relies on the `requests` library to make HTTP calls to the API.

1.  **Ensure Python is installed** (version 3.x is recommended).
2.  **Install the necessary dependencies** using pip:

    ```bash
    pip install requests
    ```

##  How to Run the Script

The script requires three command-line arguments: the base currency, the target currency, and the date.

### Usage Syntax

```bash
python currency_exchange_rate.py <BASE_CURRENCY> <TARGET_CURRENCY> <DATE_YYYY-MM-DD>