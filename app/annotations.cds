using { oBMSSrv } from '../srv/service.cds';

annotate oBMSSrv.Customer with @UI.HeaderInfo: { TypeName: 'Customer', TypeNamePlural: 'Customers', Title: { Value: customerId } };
annotate oBMSSrv.Customer with {
  ID @UI.Hidden @Common.Text: { $value: customerId, ![@UI.TextArrangement]: #TextOnly }
};
annotate oBMSSrv.Customer with @UI.Identification: [{ Value: customerId }];
annotate oBMSSrv.Customer with {
  customerId @title: 'Customer ID';
  name @title: 'Name';
  email @title: 'Email';
  phoneNumber @title: 'Phone Number'
};

annotate oBMSSrv.Customer with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: customerId },
 { $Type: 'UI.DataField', Value: name },
 { $Type: 'UI.DataField', Value: email },
 { $Type: 'UI.DataField', Value: phoneNumber }
];

annotate oBMSSrv.Customer with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: customerId },
 { $Type: 'UI.DataField', Value: name },
 { $Type: 'UI.DataField', Value: email },
 { $Type: 'UI.DataField', Value: phoneNumber }
  ]
};

annotate oBMSSrv.Customer with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate oBMSSrv.Customer with @UI.SelectionFields: [
  customerId
];

annotate oBMSSrv.PostpaidConnection with @UI.HeaderInfo: { TypeName: 'Postpaid Connection', TypeNamePlural: 'Postpaid Connections', Title: { Value: connectionId } };
annotate oBMSSrv.PostpaidConnection with {
  ID @UI.Hidden @Common.Text: { $value: connectionId, ![@UI.TextArrangement]: #TextOnly }
};
annotate oBMSSrv.PostpaidConnection with @UI.Identification: [{ Value: connectionId }];
annotate oBMSSrv.PostpaidConnection with {
  customer @Common.ValueList: {
    CollectionPath: 'Customer',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: customer_ID, 
        ValueListProperty: 'ID'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'customerId'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'name'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'email'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'phoneNumber'
      },
    ],
  }
};
annotate oBMSSrv.PostpaidConnection with {
  connectionId @title: 'Connection ID';
  planType @title: 'Plan Type';
  startDate @title: 'Start Date'
};

annotate oBMSSrv.PostpaidConnection with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: connectionId },
 { $Type: 'UI.DataField', Value: planType },
 { $Type: 'UI.DataField', Value: startDate },
    { $Type: 'UI.DataField', Label: 'Customer', Value: customer_ID }
];

annotate oBMSSrv.PostpaidConnection with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: connectionId },
 { $Type: 'UI.DataField', Value: planType },
 { $Type: 'UI.DataField', Value: startDate },
    { $Type: 'UI.DataField', Label: 'Customer', Value: customer_ID }
  ]
};

annotate oBMSSrv.PostpaidConnection with {
  customer @Common.Text: { $value: customer.customerId, ![@UI.TextArrangement]: #TextOnly }
};

annotate oBMSSrv.PostpaidConnection with {
  customer @Common.Label: 'Customer'
};

annotate oBMSSrv.PostpaidConnection with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate oBMSSrv.PostpaidConnection with @UI.SelectionFields: [
  customer_ID
];

annotate oBMSSrv.Device with @UI.HeaderInfo: { TypeName: 'Device', TypeNamePlural: 'Devices', Title: { Value: deviceId } };
annotate oBMSSrv.Device with {
  ID @UI.Hidden @Common.Text: { $value: deviceId, ![@UI.TextArrangement]: #TextOnly }
};
annotate oBMSSrv.Device with @UI.Identification: [{ Value: deviceId }];
annotate oBMSSrv.Device with {
  postpaidConnection @Common.ValueList: {
    CollectionPath: 'PostpaidConnection',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: postpaidConnection_ID, 
        ValueListProperty: 'ID'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'connectionId'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'planType'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'startDate'
      },
    ],
  }
};
annotate oBMSSrv.Device with {
  deviceId @title: 'Device ID';
  model @title: 'Model';
  price @title: 'Price';
  paymentType @title: 'Payment Type'
};

annotate oBMSSrv.Device with {
  price @Measures.ISOCurrency: Currency_code
};

annotate oBMSSrv.Device with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: deviceId },
 { $Type: 'UI.DataField', Value: model },
 { $Type: 'UI.DataField', Value: price },
 { $Type: 'UI.DataField', Value: paymentType },
    { $Type: 'UI.DataField', Label: 'Postpaid Connection', Value: postpaidConnection_ID }
];

annotate oBMSSrv.Device with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: deviceId },
 { $Type: 'UI.DataField', Value: model },
 { $Type: 'UI.DataField', Value: price },
 { $Type: 'UI.DataField', Value: paymentType },
    { $Type: 'UI.DataField', Label: 'Postpaid Connection', Value: postpaidConnection_ID }
  ]
};

annotate oBMSSrv.Device with {
  postpaidConnection @Common.Text: { $value: postpaidConnection.connectionId, ![@UI.TextArrangement]: #TextOnly }
};

annotate oBMSSrv.Device with {
  postpaidConnection @Common.Label: 'Postpaid Connection'
};

annotate oBMSSrv.Device with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate oBMSSrv.Device with @UI.SelectionFields: [
  postpaidConnection_ID
];

