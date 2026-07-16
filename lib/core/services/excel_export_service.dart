import 'dart:io';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../features/expenses/models/expense_model.dart';
import '../../features/investments/models/investment_model.dart';
import '../../features/loans/models/loan_model.dart';

class ExcelExportService {
  /// Generates a styled Excel sheet with sheets for Expenses, Loans, and Investments,
  /// saves it locally in temporary storage, and triggers the native sharing UI.
  static Future<void> exportDataToExcel({
    required List<Expense> expenses,
    required List<Loan> loans,
    required List<Investment> investments,
  }) async {
    final excel = Excel.createExcel();

    // The excel library creates "Sheet1" by default. We will rename it to "Expenses".
    if (excel.sheets.containsKey('Sheet1')) {
      excel.rename('Sheet1', 'Expenses');
    }

    final Sheet expensesSheet = excel['Expenses'];

    // Header cells styling matching Spendly primary aesthetic (Navy Blue background, white bold text)
    final headerStyle = CellStyle(
      backgroundColorHex: ExcelColor.fromHexString('#1B263B'),
      fontColorHex: ExcelColor.fromHexString('#FFFFFF'),
      bold: true,
      fontFamily: getFontFamily(FontFamily.Calibri),
    );

    final defaultStyle = CellStyle(
      fontFamily: getFontFamily(FontFamily.Calibri),
    );

    final currencyStyle = CellStyle(
      bold: true,
      fontColorHex: ExcelColor.fromHexString('#1B263B'),
      fontFamily: getFontFamily(FontFamily.Calibri),
    );

    final DateFormat dateTimeFormatter = DateFormat('yyyy-MM-dd HH:mm');
    final DateFormat dateOnlyFormatter = DateFormat('yyyy-MM-dd');

    // ────────────────────────────────────────────────────────
    // 1. EXPENSES SHEET
    // ────────────────────────────────────────────────────────
    final expenseHeaders = [
      'Date',
      'Category',
      'Merchant',
      'Payment Method',
      'Source',
      'Amount',
      'Note'
    ];

    // Write Expenses Headers
    for (var col = 0; col < expenseHeaders.length; col++) {
      final cell = expensesSheet.cell(CellIndex.indexByColumnRow(
        columnIndex: col,
        rowIndex: 0,
      ));
      cell.value = TextCellValue(expenseHeaders[col]);
      cell.cellStyle = headerStyle;
    }

    // Write Expenses Data
    for (var row = 0; row < expenses.length; row++) {
      final expense = expenses[row];
      final values = [
        TextCellValue(dateTimeFormatter.format(expense.date)),
        TextCellValue(expense.category),
        TextCellValue(expense.merchant),
        TextCellValue(expense.method.toUpperCase()),
        TextCellValue(expense.source.toUpperCase()),
        DoubleCellValue(expense.amount),
        TextCellValue(expense.note),
      ];

      for (var col = 0; col < values.length; col++) {
        final cell = expensesSheet.cell(CellIndex.indexByColumnRow(
          columnIndex: col,
          rowIndex: row + 1,
        ));
        cell.value = values[col];
        cell.cellStyle = (col == 5) ? currencyStyle : defaultStyle;
      }
    }

    // ────────────────────────────────────────────────────────
    // 2. LOANS SHEET
    // ────────────────────────────────────────────────────────
    final Sheet loansSheet = excel['Loans'];
    final loanHeaders = [
      'Created At',
      'Type',
      'Name/Person',
      'Principal',
      'Current Total',
      'Interest Rate (%)',
      'Repayment Date',
      'Status',
      'Notes'
    ];

    // Write Loans Headers
    for (var col = 0; col < loanHeaders.length; col++) {
      final cell = loansSheet.cell(CellIndex.indexByColumnRow(
        columnIndex: col,
        rowIndex: 0,
      ));
      cell.value = TextCellValue(loanHeaders[col]);
      cell.cellStyle = headerStyle;
    }

    // Write Loans Data
    for (var row = 0; row < loans.length; row++) {
      final loan = loans[row];
      final values = [
        TextCellValue(dateTimeFormatter.format(loan.createdAt)),
        TextCellValue(loan.type.toUpperCase() == 'TAKEN' ? 'Owed to Them (Taken)' : 'Owed to Me (Given)'),
        TextCellValue(loan.name),
        DoubleCellValue(loan.principal),
        DoubleCellValue(loan.currentTotal),
        DoubleCellValue(loan.interestRate),
        TextCellValue(loan.repaymentDate != null ? dateOnlyFormatter.format(loan.repaymentDate!) : 'N/A'),
        TextCellValue(loan.status.toUpperCase()),
        TextCellValue(loan.notes),
      ];

      for (var col = 0; col < values.length; col++) {
        final cell = loansSheet.cell(CellIndex.indexByColumnRow(
          columnIndex: col,
          rowIndex: row + 1,
        ));
        cell.value = values[col];
        cell.cellStyle = (col == 3 || col == 4) ? currencyStyle : defaultStyle;
      }
    }

    // ────────────────────────────────────────────────────────
    // 3. INVESTMENTS SHEET
    // ────────────────────────────────────────────────────────
    final Sheet investmentsSheet = excel['Investments'];
    final investmentHeaders = [
      'Start Date',
      'Type',
      'Name',
      'Monthly Contribution',
      'Principal Invested',
      'Maturity Amount',
      'Duration (months)',
      'Maturity Date',
      'Institution'
    ];

    // Write Investments Headers
    for (var col = 0; col < investmentHeaders.length; col++) {
      final cell = investmentsSheet.cell(CellIndex.indexByColumnRow(
        columnIndex: col,
        rowIndex: 0,
      ));
      cell.value = TextCellValue(investmentHeaders[col]);
      cell.cellStyle = headerStyle;
    }

    // Write Investments Data
    for (var row = 0; row < investments.length; row++) {
      final investment = investments[row];
      final values = [
        TextCellValue(dateOnlyFormatter.format(investment.startDate)),
        TextCellValue(investment.type.toUpperCase()),
        TextCellValue(investment.name),
        DoubleCellValue(investment.monthlyAmount),
        DoubleCellValue(investment.principal),
        DoubleCellValue(investment.maturityAmount),
        IntCellValue(investment.durationMonths),
        TextCellValue(dateOnlyFormatter.format(investment.maturityDate)),
        TextCellValue(investment.institution),
      ];

      for (var col = 0; col < values.length; col++) {
        final cell = investmentsSheet.cell(CellIndex.indexByColumnRow(
          columnIndex: col,
          rowIndex: row + 1,
        ));
        cell.value = values[col];
        cell.cellStyle = (col == 3 || col == 4 || col == 5) ? currencyStyle : defaultStyle;
      }
    }

    // Save Workbook to bytes
    final List<int>? fileBytes = excel.save();
    if (fileBytes == null) {
      throw Exception('Excel generation failed: excel.save() returned null.');
    }

    // Write to a temporary file
    final tempDir = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final filePath = '${tempDir.path}/Spendly_Export_$timestamp.xlsx';
    final file = File(filePath);
    await file.writeAsBytes(fileBytes, flush: true);

    // Share the file
    await Share.shareXFiles(
      [XFile(filePath, mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')],
      subject: 'Spendly Financial Export',
      text: 'Here is your Spendly financial export covering expenses, loans, and investments.',
    );
  }
}
