//
//  HistoryOperationView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 11.10.2024.
//

import SwiftUI

struct PaymentDayDTO: Hashable {
    let formattedDate: String
    let transactions: [TransactionDTO]
}

struct TransactionDTO: Hashable {
    let actionTitle: String
    let targetTitle: String?
    let volume: Int
    let direction: TransactionDirection
}

enum TransactionDirection {
    case icome, expence
}

protocol TransactionsViewModel: ObservableObject {
    var paymentDays: [PaymentDayDTO] { get }
}

struct TransactionsHistoryView<ViewModel: TransactionsViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                let filteredPaymentDays = viewModel.paymentDays.filter { !$0.transactions.isEmpty }
                if filteredPaymentDays.isEmpty {
                    NoDataView(text: Constants.Text.homeViewNoData)
                } else {
                    ForEach(viewModel.paymentDays, id: \.self) { day in
                        VStack(alignment: .leading) {
                            Text(day.formattedDate)
                                .font(.headline)
                                .padding(.bottom)
                            
                            ForEach(day.transactions, id: \.self) { transaction in
                                TransactionItem(transaction: transaction)
                                    .padding(.bottom, 4)
                                
                                if transaction != day.transactions.last {
                                    Divider()
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(Constants.Text.bonusViewHistoryTransactions)
        }
    }
}

private struct TransactionItem: View {
    let transaction: TransactionDTO
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.actionTitle)
                if let target = transaction.targetTitle {
                    Text(target)
                        .font(.callout)
                }
            }
            Spacer()
            Text("\(transaction.direction.sign)\(transaction.volume)")
                .foregroundStyle(transaction.direction.color)
                .font(.callout)
        }
    }
}

extension TransactionDirection {
    var sign: String {
        switch (self) {
        case .icome: "+"
        case .expence: "-"
        }
    }
    
    var color: Color {
        switch (self) {
        case .icome: Color.green
        case .expence: Color.red
        }
    }
}

#Preview {
    TransactionsHistoryView(viewModel: MockTransactionsViewModel())
}

class MockTransactionsViewModel: TransactionsViewModel {
    @Published private(set) var paymentDays: [PaymentDayDTO]
    
    init() {
        self.paymentDays = [
            PaymentDayDTO(
                formattedDate: "3 августа",
                transactions: [
                    TransactionDTO(
                        actionTitle: "Покупка предложения",
                        targetTitle: "Zara home",
                        volume: 150,
                        direction: .expence
                    ),
                    TransactionDTO(
                        actionTitle: "Покупка предложения",
                        targetTitle: "Nike",
                        volume: 150,
                        direction: .expence
                    )
                ]
            ),
            PaymentDayDTO(
                formattedDate: "25 июля",
                transactions: [
                    TransactionDTO(
                        actionTitle: "Регистрация на мероприятия",
                        targetTitle: nil,
                        volume: 300,
                        direction: .expence
                    ),
                    TransactionDTO(
                        actionTitle: "Начисление бонусов за регистрацию",
                        targetTitle: nil,
                        volume: 1500,
                        direction: .icome
                    )
                ]
            )
        ]
    }
}
