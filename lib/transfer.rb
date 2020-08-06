require "pry"
class Transfer
  attr_reader :amount, :sender, :receiver
  attr_accessor :status
  def initialize(sender,receiver,amount)
    @amount = amount
    @sender = sender
    @receiver = receiver
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if check_accounts
      receiver.deposit(self.amount)
      sender.balance -= self.amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end

  end

  def check_accounts
    valid? && sender.balance > amount && self.status == "pending"
  end

  def reverse_check_accounts
    valid? && receiver.balance > amount && self.status == "complete"
  end
  
  def reverse_transfer
    if reverse_check_accounts
      sender.deposit(self.amount)
      receiver.balance -= self.amount
      self.status = "reversed"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
end
