// import 'package:moneytrack/global_resources/controllers/department/data_flow.dart';
//
// import '../../screens/moneyTrack/models/account.dart';
// import '../../screens/moneyTrack/models/track.dart';
// import '../../screens/moneyTrack/models/transaction.dart';
// import '../../screens/moneyTrack/models/transaction_cost.dart';
//
// List<Account> demo_accounts = [
//   const Account(
//     uploadStatus: UploadStatus.uploadInProgress,
//     id: 'ADAPEBZBNBDU',
//     name: 'Web App',
//     description: 'Web interface where payments are made',
//     disburseOnReceive: true,
//     apiEnabled: true,
//     nextOfKin: 'MpesaPaybill',
//     transactionCost: TransactionCost(
//       transactionCostName: 'Mpesa Paybill business',
//       depositAccount: 'Safaricom',
//       upperLimit: 1,
//       lowerLimit: 150000,
//       percentage: 0,
//       percentageTable: <String,double>{
//         'a0low':1,'a0upper':1000,'a0cost':0,
//         'a1low':1001,'a1upper':1500,'a1cost':5,
//         'a2low':1501,'a2upper':2500,'a2cost':7,
//         'a3low':2501,'a3upper':3500,'a3cost':9,
//         'a4low':3501,'a4upper':5500,'a4cost':17,
//       },
//       transactionCostType: TransactionCostType.table
//   ),),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPEBZBNBMG',name: 'MpesaPaybill', description: 'Payment made are deposited here'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPEBZBOAHM',name: 'KCB Bank', description: 'settlement are made here from mpesa paybill'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPEBZBOAPF',name: 'Transaction Costs', description: 'Account for tracking TransactionCost'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPEBZBOAWZ',name: 'Marvin\'s Wallet', description: 'Account for tracking withdrawn cash'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPEBZBOBES',name: 'Marvin\'s Mpesa', description: 'Account for tracking money deposited to mpesa'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPEBZBOBML',name: 'Expenses', description: 'Account for tracking expenditure during the hike day'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPEBZBPAHS',name: 'Refund', description: 'Account for tracking refunds'),
// ];
// List<Sheet> demo_sheets = [
//   // const Sheet(name: 'Expenditure',uploadStatus: UploadStatus.uploadSuccessful),
//   // const Sheet(name: 'Pilgrims App',uploadStatus: UploadStatus.uploadSuccessful),
// ];
// List<Account> demo_pilgrim_account = [
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPECBAFAYD',name: 'House A', description: 'Account for tracking House A transactions',disburseOnReceive: true, nextOfKin: 'Mpesa Till Banking'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPECBAFBGP',name: 'House B', description: 'Account for tracking House B transactions',disburseOnReceive: true, nextOfKin: 'Mpesa Till Banking'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPECBAGABW',name: 'Kitchen', description: 'Account for tracking Kitchen transactions',disburseOnReceive: true, nextOfKin: 'Mpesa Till Banking'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPECBAGAJO',name: 'Soda', description: 'Account for tracking soda sales/purchases',disburseOnReceive: true, nextOfKin: 'Mpesa Till Banking'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPECBAGARI',name: 'Mpesa Till Banking', description: 'All payments are deposited here'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPECBAGAZB',name: 'Expenses', description: 'All payments are deposited here'),
//   const Account(uploadStatus: UploadStatus.uploadInProgress,id: 'ADAPECBAGBGU',name: 'Transaction Costs', description: 'Account for tracking Transaction costs'),
// ];
// List<Transaction> demo_transactions = [
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-15',dna: 'WebAppCashIn',transactionId: 'RBF1OMR64N', transactor: 'SUSAN MUTUNE', amount: 1500.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-18',dna: 'WebAppCashIn',transactionId: 'RBI4XDBMDC', transactor: 'TESS WAMBUI', amount: 1500.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-21',dna: 'WebAppCashIn',transactionId: 'RBL9648PR9', transactor: 'KELVIN OGUM', amount: 1415.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-21',dna: 'WebAppCashIn',transactionId: 'RBL370W0J5', transactor: 'PHIDEL OCHOLA', amount: 2500.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-21',dna: 'WebAppCashIn',transactionId: 'RBL37GDSS1', transactor: 'MARVIN OGUTU', amount: 8.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-22',dna: 'WebAppCashIn',transactionId: 'RBM27YC31A', transactor: 'JOYCE CHELANGAT', amount: 3750.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-22',dna: 'WebAppCashIn',transactionId: 'RBM5A04SW1', transactor: 'MARVIN OGUTU', amount: 1150.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN9A1I2WV', transactor: 'HEZEKIAH OYUGI', amount: 1500.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN6A9VXTE', transactor: 'MARVIN OGUTU', amount: 755.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN7AA4WF1', transactor: 'CAROLINE MURIMI', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN3ADM11B', transactor: 'MARVIN OGUTU', amount: 1254.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN1AF33ZZ', transactor: 'MARVIN OGUTU', amount: 1252.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN0AF83D6', transactor: 'JACKLINE MUMBUA', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN8AFHIYY', transactor: 'DIANA MWEBA', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN6AG8DP4', transactor: 'CHRISTINE MONCHARI', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN6AI1WRS', transactor: 'FERAH MORAA', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'MpesaPaybillCashOutKCBBankCashIn',transactionId: 'RBN6B1BUWQ', transactor: 'Settlement To KCB', amount: 22750.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'KCBBankCashOutMarvin\'sWalletCashIn',transactionId: 'W001', transactor: 'ATM Withdrawal', amount: 17000.00),//FIRST WITHDRAWAL
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'KCBBankCashOutTransactionCostsCashIn',transactionId: 'W001', transactor: 'TXN COST', amount: 36.00),//FIRST WITHDRAWAL
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'Marvin\'sWalletCashOutExpensesCashIn',transactionId: 'C001', transactor: 'BUS HIRE', amount: 16550.00),//FIRST EXPENSE DUE TO BUS HIRE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN5B4TSSZ', transactor: 'RIECELLE WATI', amount: 5000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN6B6LI5K', transactor: 'MERCY KIENDE', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN6B8LH18', transactor: 'KEVIN BAGWASI', amount: 5000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN8BBPG9G', transactor: 'LANINA MWIKALI', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN9BF5C3D', transactor: 'ANNETTE AJIANDO', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN2BKKV5A', transactor: 'NIXON KIPKOECH', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'Marvin\'sMpesaCashIn',transactionId: 'RBN4BHOEDA', transactor: 'DAVID MAINA', amount: 1500.00),//PAID FOR SOMEONE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'Marvin\'sMpesaCashOutMpesaPaybillCashIn',transactionId: 'RBN3BLS5XZ', transactor: 'MARVIN OGUTU', amount: 1500.00),//PAID FOR SOMEONE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'MpesaPaybillCashOutTransactionCostsCashIn',transactionId: 'RBN3BLS5XZ', transactor: 'TXN COST', amount: 5.00),//TXN COST
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'Marvin\'sMpesaCashOutTransactionCostsCashIn',transactionId: 'RBN3BLS5XZ', transactor: 'TXN COST', amount: 9.00),//PAID FOR SOMEONE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN1C57U39', transactor: 'KEVIN APOLO', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN2CHIQFE', transactor: 'NICOLE CHEMUTAI', amount: 4809.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN3CHOESN', transactor: 'NICOLE CHEMUTAI', amount: 191.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'WebAppCashIn',transactionId: 'RBN2CIPP2A', transactor: 'MARION CHEROTICH', amount: 2500.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO4CPJKGM', transactor: 'DENIS MUNENE', amount: 1500.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO1CRNB35', transactor: 'MARION CHEROTICH', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO6CVHZHE', transactor: 'ALLAN MUGAMBI', amount: 3750.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'Marvin\'sWalletCashIn',transactionId: 'TC001', transactor: 'EUNICE NDUNGU', amount: 50.00),//PAID FOR SOMEONE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO8D206LQ', transactor: 'WILLIAM WAMALWA', amount: 3750.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO1D65TK3', transactor: 'KENNETH NJENGA', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO3DBCW1J', transactor: 'GRACE GATHONI', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'Marvin\'sMpesaCashIn',transactionId: 'RBO5DC7B43', transactor: 'ANTONY NDEGWA', amount: 5000.00),//PAID FOR SOMEONE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'Marvin\'sMpesaCashOutMpesaPaybillCashIn',transactionId: 'RBO5DC7B43', transactor: 'MARVIN OGUTU', amount: 5000.00),//PAID FOR SOMEONE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'MpesaPaybillCashOutTransactionCostsCashIn',transactionId: 'RBO5DC7B43', transactor: 'TXN COST', amount: 17.00),//PAID FOR SOMEONE TXN COST
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'Marvin\'sMpesaCashOutTransactionCostsCashIn',transactionId: 'RBO5DC7B43', transactor: 'TXN COST', amount: 16.00),//PAID FOR SOMEONE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO7DOEV3H', transactor: 'ISAAC SIKUKU', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO6DUM2NQ', transactor: 'KENNETH NJENGA', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO9E1Y0XH', transactor: 'KEVIN OGUM', amount: 85.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO5E4BTOX', transactor: 'ABRAHAM LOKENO', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO7E58H0D', transactor: 'NAOMI NZIOKI', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO5E5W6CV', transactor: 'CAREN CHEROTICH', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO1EDXVIR', transactor: 'KELVIN KIPCHUMBA', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO9EEY2Z5', transactor: 'JEFF OCHIENG', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'MpesaPaybillCashOutKCBBankCashIn',transactionId: 'RBO6EIU7ZC', transactor: 'Settlement To KCB', amount: 51641.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'KCBBankCashOutMarvin\'sWalletCashIn',transactionId: 'W002', transactor: 'ATM Withdrawal', amount: 40000.00),//SECOND WITHDRAWAL
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'KCBBankCashOutTransactionCostsCashIn',transactionId: 'W002', transactor: 'TXN COST', amount: 36.00),//SECOND WITHDRAWAL
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO3EVM1KF', transactor: 'GRACE MUTHONI', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO9F04YRJ', transactor: 'SAMSON OMONDI', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO0F4LAM8', transactor: 'ZEKTABA NASAMBU', amount: 1500.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO7F5E017', transactor: 'ELVIS MASINDE', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO1F6NALL', transactor: 'ESTHER KWAMBOKA', amount: 1500.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'WebAppCashIn',transactionId: 'RBO9F8SL6V', transactor: 'CAROLINE MURIMI', amount: 1250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sWalletCashOutExpensesCashIn',transactionId: 'C002', transactor: 'BUS FUEL KESSES', amount: 10000.00),//EXPENSE DUE TO BUS FUEL
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sWalletCashOutExpensesCashIn',transactionId: 'C003', transactor: 'DRIVER PER DIEM', amount: 4900.00),//EXPENSE DUE TO PER DIEM
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'MpesaPaybillCashOutKCBBankCashIn',transactionId: 'RBP6FQWVS4', transactor: 'Settlement To KCB', amount: 7970.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'KCBBankCashOutMarvin\'sMpesaCashIn',transactionId: 'W003', transactor: 'Mtaani Withdrawal', amount: 23000.00),//THIRD WITHDRAWAL
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'KCBBankCashOutTransactionCostsCashIn',transactionId: 'W003', transactor: 'TXN COST', amount: 105.00),//THIRD WITHDRAWAL
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sWalletCashOutExpensesCashIn',transactionId: 'C004', transactor: 'BUS FUEL NAKURU', amount: 4000.00),//EXPENSE DUE TO BUS FUEL
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sMpesaCashOutExpensesCashIn',transactionId: 'RBP1G6LKNF', transactor: 'Entrance Fee', amount: 16800.00),//EXPENSE DUE TO ENTRANCE FEE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sMpesaCashOutTransactionCostsCashIn',transactionId: 'RBP1G6LKNF', transactor: 'TXN COST', amount: 60.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sWalletCashOutExpensesCashIn',transactionId: 'C005', transactor: 'Catering Deposit', amount: 600.00),//EXPENSE DUE TO Catering
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sMpesaCashOutExpensesCashIn',transactionId: 'RBP7G7A5BX', transactor: 'Catering deposit', amount: 2300.00),//EXPENSE DUE TO catering
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sMpesaCashOutTransactionCostsCashIn',transactionId: 'RBP7G7A5BX', transactor: 'TXN COST', amount: 32.00),//TXN COST
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sMpesaCashOutExpensesCashIn',transactionId: 'RBP3GXFZ31', transactor: 'Catering clearance', amount: 4600.00),//EXPENSE DUE TO catering clearance
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sMpesaCashOutTransactionCostsCashIn',transactionId: 'RBP3GXFZ31', transactor: 'TXN COST', amount: 55.00),//TXN COST
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sWalletCashOutExpensesCashIn',transactionId: 'C006', transactor: 'TOUR GUIDE', amount: 2000.00),//EXPENSE DUE TO TOUR GUIDE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sWalletCashOutExpensesCashIn',transactionId: 'C007', transactor: 'BUS FUEL GILGIL', amount: 13000.00),//EXPENSE DUE TO BUS FUEL
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sMpesaCashOutExpensesCashIn',transactionId: 'RBP0FSYIO6', transactor: 'STAFF allowance', amount: 1000.00),//EXPENSE DUE TO STAFF
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'Marvin\'sMpesaCashOutTransactionCostsCashIn',transactionId: 'RBP0FSYIO6', transactor: 'TXN COST', amount: 12.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'Marvin\'sWalletCashOutExpensesCashIn',transactionId: 'C008', transactor: 'CAMERA HIRE', amount: 1000.00),//EXPENSE DUE To CAMERA ALLOWANCE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-26',dna: 'Marvin\'sWalletCashOutRefundCashIn',transactionId: 'RBQ0K85336', transactor: 'REFUND', amount: 1250.00),//EXPENSE DUE To CAMERA ALLOWANCE
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-26',dna: 'Marvin\'sMpesaCashOutTransactionCostsCashIn',transactionId: 'RBQ0K85336', transactor: 'TXN COST', amount: 22.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-26',dna: 'Marvin\'sWalletCashOutExpensesCashIn',transactionId: 'C009', transactor: 'Post event particulars', amount: 800.00),//EXPENSE DUE To post event
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-26',dna: 'Marvin\'sWalletCashOutExpensesCashIn',transactionId: 'C010', transactor: 'Photo upload', amount: 100.00),//EXPENSE DUE To photos
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-26',dna: 'Marvin\'sWalletCashOutExpensesCashIn',transactionId: 'C010', transactor: 'Post event particulars', amount: 790.00),//EXPENSE DUE To post event
// ];
// List<Transaction> demo_pilgrim_transaction = [
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-01-03',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO96', transactor: 'Gas', amount: 5880.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-01',dna: 'KitchenCashIn',transactionId: 'T001', transactor: 'TOO1', amount: 4050.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-02',dna: 'HouseACashIn',transactionId: 'T002', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-02',dna: 'HouseACashIn',transactionId: 'T004', transactor: 'Room 3', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-02',dna: 'KitchenCashIn',transactionId: 'T005', transactor: 'TOO5', amount: 4150.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-02',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'T006', transactor: 'SOFI ADVANCE', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-02',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'T007', transactor: 'GUSII WATER', amount: 1130.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-02',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'T008', transactor: '2 CEMENT (GATE)', amount: 1440.00),//CHECK FOR SQL BRACKET ERROR
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-03',dna: 'HouseACashIn',transactionId: 'T009', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-03',dna: 'HouseBCashIn',transactionId: 'T010', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-03',dna: 'KitchenCashIn',transactionId: 'T011', transactor: 'TO11', amount: 1650.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-03',dna: 'KitchenCashOutExpensesCashIn',transactionId: 'T012', transactor: 'Four Chicken(Onyambu)', amount: 3300.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-03',dna: 'KitchenCashOutTransactionCostsCashIn',transactionId: 'T012', transactor: 'Txn cost', amount: 51.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-04',dna: 'HouseACashIn',transactionId: 'T013', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-04',dna: 'HouseACashIn',transactionId: 'T014', transactor: 'Room 6', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-04',dna: 'KitchenCashIn',transactionId: 'T015', transactor: 'TO15', amount: 1600.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-05',dna: 'HouseACashIn',transactionId: 'T016', transactor: 'Room 1', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-05',dna: 'HouseACashIn',transactionId: 'T017', transactor: 'Room 5', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-05',dna: 'HouseACashIn',transactionId: 'T018', transactor: 'Room 6', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-05',dna: 'HouseBCashIn',transactionId: 'T019', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-05',dna: 'KitchenCashIn',transactionId: 'T020', transactor: 'TO20', amount: 1850.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-05',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'T021', transactor: 'Wifi, Security', amount: 10000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-05',dna: 'MpesaTillBankingCashOutTransactionCostsCashIn',transactionId: 'T021', transactor: 'Txn cost', amount: 40.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-06',dna: 'HouseBCashIn',transactionId: 'T022', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-06',dna: 'KitchenCashIn',transactionId: 'T023', transactor: 'TO23', amount: 3000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-07',dna: 'KitchenCashIn',transactionId: 'T024', transactor: 'TO24', amount: 1670.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-07',dna: 'KitchenCashOutExpensesCashIn',transactionId: 'T025', transactor: '10 kuku@700', amount: 7000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-07',dna: 'KitchenCashOutExpensesCashIn',transactionId: 'T026', transactor: 'unga', amount: 2000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-07',dna: 'SodaCashIn',transactionId: 'T027', transactor: 'TO27', amount: 560.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-07',dna: 'SodaCashOutExpensesCashIn',transactionId: 'T028', transactor: 'Delmonte', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-07',dna: 'SodaCashOutExpensesCashIn',transactionId: 'T029', transactor: 'Water', amount: 580.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-08',dna: 'HouseACashIn',transactionId: 'T030', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-08',dna: 'SodaCashIn',transactionId: 'T031', transactor: 'TO31', amount: 450.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-08',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO32', transactor: 'Orwaru, Fumigation, Electricity', amount: 10100.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-08',dna: 'MpesaTillBankingCashOutTransactionCostsCashIn',transactionId: 'TO32', transactor: 'Txn cost', amount: 87.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-09',dna: 'HouseACashIn',transactionId: 'T033', transactor: 'Room 6', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-09',dna: 'KitchenCashIn',transactionId: 'T035', transactor: 'TO34', amount: 1770.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-09',dna: 'KitchenCashOutExpensesCashIn',transactionId: 'T035', transactor: 'Mboga', amount: 400.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-09',dna: 'KitchenCashOutExpensesCashIn',transactionId: 'T036', transactor: 'Tea Leaves', amount: 30.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-09',dna: 'SodaCashIn',transactionId: 'T037', transactor: 'TO37', amount: 300.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-10',dna: 'HouseACashIn',transactionId: 'T038', transactor: 'Room 2', amount: 2400.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-10',dna: 'KitchenCashIn',transactionId: 'T039', transactor: 'TO39', amount: 2500.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-10',dna: 'SodaCashIn',transactionId: 'T040', transactor: 'TO40', amount: 340.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-10',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO41', transactor: 'Orwaru', amount: 700.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-11',dna: 'KitchenCashIn',transactionId: 'T042', transactor: 'TO42', amount: 2200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-11',dna: 'SodaCashIn',transactionId: 'T043', transactor: 'TO43', amount: 1030.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-11',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO44', transactor: 'Grace Salary', amount: 10000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-11',dna: 'MpesaTillBankingCashOutTransactionCostsCashIn',transactionId: 'TO44', transactor: 'Txn cost', amount: 87.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-12',dna: 'HouseBCashIn',transactionId: 'T045', transactor: 'Room 1', amount: 2400.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-12',dna: 'KitchenCashIn',transactionId: 'T046', transactor: 'TO46', amount: 750.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-12',dna: 'SodaCashIn',transactionId: 'T047', transactor: 'TO47', amount: 630.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-12',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO48', transactor: 'Sofi', amount: 2300.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-12',dna: 'MpesaTillBankingCashOutTransactionCostsCashIn',transactionId: 'TO48', transactor: 'Txn cost', amount: 32.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-13',dna: 'HouseACashIn',transactionId: 'T049', transactor: 'Room 1', amount: 4400.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-13',dna: 'HouseBCashIn',transactionId: 'T050', transactor: 'Room 1', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-13',dna: 'KitchenCashIn',transactionId: 'T051', transactor: 'TO51', amount: 4900.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-13',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO52', transactor: 'expenses', amount: 900.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-14',dna: 'HouseACashIn',transactionId: 'T053', transactor: 'Room 1', amount: 3200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-14',dna: 'HouseBCashIn',transactionId: 'T054', transactor: 'Room 1', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-14',dna: 'KitchenCashIn',transactionId: 'T055', transactor: 'TO55', amount: 2750.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-14',dna: 'KitchenCashOutExpensesCashIn',transactionId: 'T056', transactor: 'Banana', amount: 400.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-14',dna: 'KitchenCashOutExpensesCashIn',transactionId: 'T057', transactor: 'Mboga', amount: 400.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-14',dna: 'KitchenCashOutExpensesCashIn',transactionId: 'T058', transactor: 'Maziwa', amount: 75.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-14',dna: 'SodaCashIn',transactionId: 'T059', transactor: 'TO59', amount: 890.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-14',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO60', transactor: 'Tissue', amount: 1050.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-15',dna: 'HouseBCashIn',transactionId: 'T061', transactor: 'Room 1', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-15',dna: 'KitchenCashIn',transactionId: 'T062', transactor: 'TO62', amount: 3350.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-15',dna: 'SodaCashIn',transactionId: 'T063', transactor: 'TO63', amount: 750.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-16',dna: 'HouseBCashIn',transactionId: 'T064', transactor: 'Room 1', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-16',dna: 'KitchenCashIn',transactionId: 'T065', transactor: 'TO65', amount: 1550.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-16',dna: 'KitchenCashOutExpensesCashIn',transactionId: 'T065', transactor: '5 kuku@800', amount: 4000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-17',dna: 'KitchenCashIn',transactionId: 'T066', transactor: 'TO66', amount: 3800.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-18',dna: 'KitchenCashIn',transactionId: 'T067', transactor: 'TO67', amount: 4250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-18',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO68', transactor: 'Chicken mboga', amount: 4400.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-18',dna: 'MpesaTillBankingCashOutTransactionCostsCashIn',transactionId: 'TO68', transactor: 'Txn cost', amount: 55.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-19',dna: 'HouseACashIn',transactionId: 'T069', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-19',dna: 'KitchenCashIn',transactionId: 'T069', transactor: 'TO69', amount: 450.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-20',dna: 'HouseACashIn',transactionId: 'T070', transactor: 'Room 6', amount: 2000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-20',dna: 'HouseBCashIn',transactionId: 'T071', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-20',dna: 'KitchenCashIn',transactionId: 'T072', transactor: 'TO72', amount: 3450.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-21',dna: 'HouseACashIn',transactionId: 'T073', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-21',dna: 'HouseBCashIn',transactionId: 'T074', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-21',dna: 'KitchenCashIn',transactionId: 'T075', transactor: 'TO75', amount: 2000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-21',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO76', transactor: 'Meat', amount: 1400.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-21',dna: 'MpesaTillBankingCashOutTransactionCostsCashIn',transactionId: 'TO76', transactor: 'Txn cost', amount: 24.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-22',dna: 'HouseACashIn',transactionId: 'T077', transactor: 'Room 6', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-22',dna: 'KitchenCashIn',transactionId: 'T078', transactor: 'TO78', amount: 1800.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'KitchenCashIn',transactionId: 'T079', transactor: 'TO79', amount: 2050.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO80', transactor: '5 kuku', amount: 3500.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-23',dna: 'MpesaTillBankingCashOutTransactionCostsCashIn',transactionId: 'TO80', transactor: 'Txn cost', amount: 51.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'KitchenCashIn',transactionId: 'T081', transactor: 'TO81', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO82', transactor: 'Otara', amount: 20000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-24',dna: 'MpesaTillBankingCashOutTransactionCostsCashIn',transactionId: 'TO82', transactor: 'Txn cost', amount: 102.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'HouseACashIn',transactionId: 'T083', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'HouseACashIn',transactionId: 'T084', transactor: 'Room 6', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'HouseBCashIn',transactionId: 'T085', transactor: 'Room 1', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'KitchenCashIn',transactionId: 'T086', transactor: 'TO86', amount: 3500.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO87', transactor: 'Okeyo', amount: 300.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-25',dna: 'MpesaTillBankingCashOutTransactionCostsCashIn',transactionId: 'TO87', transactor: 'Txn cost', amount: 6.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-26',dna: 'HouseACashIn',transactionId: 'T088', transactor: 'Room 2', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-26',dna: 'HouseACashIn',transactionId: 'T089', transactor: 'Room 6', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-26',dna: 'KitchenCashIn',transactionId: 'T090', transactor: 'TO90', amount: 2550.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-27',dna: 'HouseACashIn',transactionId: 'T091', transactor: 'Room 2', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-27',dna: 'KitchenCashIn',transactionId: 'T092', transactor: 'TO92', amount: 2450.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-28',dna: 'HouseACashIn',transactionId: 'T093', transactor: 'Room 1', amount: 1000.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-28',dna: 'HouseACashIn',transactionId: 'T094', transactor: 'Room 2', amount: 1200.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-28',dna: 'KitchenCashIn',transactionId: 'T095', transactor: 'TO95', amount: 3250.00),
//   const Transaction(uploadStatus:UploadStatus.uploadSuccessful,date: '2023-02-28',dna: 'MpesaTillBankingCashOutExpensesCashIn',transactionId: 'TO96', transactor: 'Soda,water, kuku', amount: 5880.00),
// ];
// List<TransactionCost> transactionCosts = [
//   const TransactionCost(
//       transactionCostName: 'Mpesa Paybill business',
//       depositAccount: 'Safaricom',
//       upperLimit: 1,
//       lowerLimit: 150000,
//       percentage: 0,
//       percentageTable: <String,double>{
//         'a0low':1,'a0upper':1000,'a0cost':0,
//         'a1low':1001,'a1upper':1500,'a1cost':5,
//         'a2low':1501,'a2upper':2500,'a2cost':7,
//         'a3low':2501,'a3upper':3500,'a3cost':9,
//         'a4low':3501,'a4upper':5500,'a4cost':17,
//       },
//       transactionCostType: TransactionCostType.table
//   ),
//   const TransactionCost(
//       transactionCostName: 'Mpesa Paybill Customer',
//       depositAccount: 'Safaricom',
//       upperLimit: 1,
//       lowerLimit: 150000,
//       percentage: 0,
//       percentageTable: <String,double>{
//         'a0low':1,'a0upper':100,'a0cost':0,
//         'a1low':101,'a1upper':500,'a1cost':4,
//         'a2low':501,'a2upper':1500,'a2cost':9,
//       },
//       transactionCostType: TransactionCostType.table
//   )
// ];