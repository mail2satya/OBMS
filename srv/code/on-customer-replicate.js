/**
 * The custom logic to replicate customer master data to HANA Cloud once the initial data is filled.
 * @On(event = { "replicate" }, entity = "oBMSSrv.Customer")
 * @param {cds.Request} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = async function(request) {
    const { Customer } = cds.entities;

    // The key of the customer is passed in request.params for a bound action
    const customerKey = request.params[0]?.ID || request.params[0];

    // Retrieve the customer data from the database
    const customer = await SELECT.one.from(Customer).where({ ID: customerKey });

    if (!customer) {
        return request.reject(404, 'Customer not found.');
    }

    // Check if the customer data is fully populated
    if (!customer.name || !customer.email || !customer.phoneNumber) {
        return request.reject(400, 'Customer data is incomplete. Replication aborted.');
    }

    // --- Start of simulated replication logic ---
    try {
        console.log(`Replicating customer data for customer: ${customer.name} (${customer.ID}) to HANA Cloud.`);

        // Simulate a network call to an external replication service.
        // In a real application, you would use the SAP Cloud SDK to call an external service.
        await new Promise(resolve => setTimeout(resolve, 2000)); // 2-second delay

        console.log(`Successfully replicated customer: ${customer.name} (${customer.ID})`);

        // Return a success message to be displayed in the UI.
        request.notify(`Replication for ${customer.name} completed successfully.`);
        return { success: true, message: 'Customer data replicated successfully to HANA Cloud.' };

    } catch (error) {
        console.error(`Replication failed for customer: ${customer.name} (${customer.ID})`, error);
        return request.reject(500, 'An error occurred during replication.');
    }
    // --- End of simulated replication logic ---
}
