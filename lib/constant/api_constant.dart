// base url
const kBaseUrl = 'https://api.good2luck.com';
// const kBaseUrl ="http://192.168.100.76";
// const kBaseUrl = 'http://192.168.100.161';

// end point
const kAccessToken = '/api/Auth/access-token';
const kGetIssue = '/api/IssueStocks';
const kRefreshToken = "/api/Auth/refresh-token";
const kGetGoldPrice = '/api/MainStock/goldprices';
const kGetSaleCustomer = '/api/Customers';
const kCreateVoucher = '/api/Sales/create-salevoucher';
const kGetSaleVoucher = '/api/Sales/salevoucher/byuser';
const kGetSaleVoucherDetail = '/api/Sales/salevodetail';
const kDeleteSaleVoucher = '/api/Sales/delete-salevoucher';
const kGetReturnVoucher = '/api/ReturnVoucher';
const kCreateReturnVoucher = '/api/ReturnVoucher/create';
const kDeleteReturnVoucher = '/api/ReturnVoucher/delete';
const kGetReturnVouchersDetail = '/api/ReturnVoucher/detail';
const kGetMainStock = '/api/MainStock/stocks';
const kGetItemTypes = '/api/MainStock/itemtypes';
const kCreateTransferVo = "/api/TransferVouchers/create";
const kGetMarketing = '/api/Marketing';
const kGetSaleVoucherByCustomer = "/api/Customers/salevoucher";
const kGetCustomerReturnVouchers = '/api/Customers/returnvoucher';
const kGetCustomerPayment = '/api/Customers/payment';
const kCreateCustomerPayment = '/api/CustomerPayment/create';
const kGetStatement = '/api/CustomerPayment';
const kRegisterNotiToken= "/api/Notifications/register-token";
const kGetTransfersVouchers = "/api/TransferVouchers";
const kGetTransferVoucherDetail = '/api/TransferVouchers/detail';
const kDeleteCustomerPayment= '/api/CustomerPayment/delete';
const kDeleteTransferVoucher = '/api/TransferVouchers/delete';
const kGetReceivedTransferVouchers = '/api/TransferVouchers/pending-voucher';
const kReceivedTransferVouchers = '/api/TransferVouchers/receive';
const kCheckDevice = '/api/Auth/check-userdevice';
const kGetCustomerStocks = "/api/Customers/stocks";