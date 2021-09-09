class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize sender, receiver, amount
      @sender = sender
      @receiver = receiver
      @amount = amount
      @status = 'pending'
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if valid? && @status == 'pending' && @receiver.balance > amount
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @status = "reversed"
      @sender.balance += @amount
      @receiver.balance -= @amount
    end
  end
end
