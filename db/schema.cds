namespace OBMS;
using { cuid, Currency } from '@sap/cds/common';

@assert.unique: { customerId: [customerId] }
entity Customer : cuid {
  customerId: String(50) @mandatory;
  name: String(100);
  email: String(100);
  phoneNumber: String(15);
  photo: LargeBinary @mandatory;
}

@assert.unique: { connectionId: [connectionId] }
entity PostpaidConnection : cuid {
  connectionId: String(50) @mandatory;
  planType: String(50);
  startDate: Date;
  customer: Association to Customer;
}

@assert.unique: { deviceId: [deviceId] }
entity Device : cuid {
  deviceId: String(50) @mandatory;
  model: String(100);
  price: Decimal(10,2);
  Currency: Currency;
  paymentType: String(50);
  postpaidConnection: Association to PostpaidConnection;
}