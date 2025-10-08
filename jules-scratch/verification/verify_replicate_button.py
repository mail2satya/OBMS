import time
from playwright.sync_api import sync_playwright, Page, expect

def run(playwright):
    browser = playwright.chromium.launch(headless=True)
    context = browser.new_context()
    page = context.new_page()

    try:
        verify_replicate_button_is_visible(page)
    finally:
        browser.close()

def verify_replicate_button_is_visible(page: Page):
    """
    This test verifies that the 'Replicate Customer' button is visible
    on the Customer Object Page.
    """
    # Generate a unique customer ID to avoid conflicts from previous runs
    customer_id = f"CUST-{int(time.time())}"
    customer_name = f"Test Customer {customer_id}"

    # 1. Arrange: Go to the Customer Management application directly.
    page.goto("http://localhost:4004/customer-management/webapp/index.html", wait_until="networkidle")

    # Wait for the page to load and find the "Create" button.
    # The page might take a while to load all the UI5 components
    create_button = page.get_by_role("button", name="Create")
    expect(create_button).to_be_visible(timeout=60000) # Increased timeout
    create_button.click()

    # We are now on the Object Page in create mode.
    # Wait for the header to be visible before filling fields
    expect(page.get_by_role("heading", name="Customer", exact=True)).to_be_visible()

    # Fill in some mandatory fields.
    page.get_by_label("Customer ID").fill(customer_id)
    page.get_by_label("Name").fill(customer_name)
    page.get_by_label("Email").fill("test@customer.com")
    page.get_by_label("Phone Number").fill("1234567890")

    # Click the "Create" button on the Object Page footer to save the new customer.
    save_button = page.get_by_role("button", name="Create", exact=True)
    expect(save_button).to_be_enabled()
    save_button.click()

    # Now we should be back on the list report, and the new customer should be there.
    # Wait for the table to refresh and show the new customer.
    expect(page.get_by_role("cell", name=customer_name)).to_be_visible()

    # Now click the customer to navigate to the object page.
    page.get_by_role("cell", name=customer_name).click()

    # We should now be on the Object Page for the new customer.
    # The "Replicate Customer" button should be visible in the header.
    replicate_button = page.get_by_role("button", name="Replicate Customer")
    expect(replicate_button).to_be_visible()

    # 4. Screenshot: Capture the final result for visual verification.
    page.screenshot(path="jules-scratch/verification/verification.png")


if __name__ == "__main__":
    with sync_playwright() as playwright:
        run(playwright)