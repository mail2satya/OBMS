using { OBMS as my } from '../db/schema.cds';

@path: '/service/oBMS'
@requires: 'authenticated-user'
service oBMSSrv {
  @odata.draft.enabled
  entity Customer as projection on my.Customer actions {
    action replicate();
  }
  entity Photo as projection on my.Photo;
  @odata.draft.enabled
  entity PostpaidConnection as projection on my.PostpaidConnection;
  @odata.draft.enabled
  entity Device as projection on my.Device;
}