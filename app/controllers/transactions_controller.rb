class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = {}
    @total_balance = 0
    @store_balance = {}

    Transaction.where(user_id: current_user.id).order(:store, :id).each do |transaction|
      attributes = transaction.attributes
      
      unless @transactions[attributes['store']]
        @store_balance[attributes['store']] = 0
        @transactions[attributes['store']] = []
      end

      attributes['transaction_type'] = transaction.transaction_type
      
      if transaction.transaction_type.signal === "+"
        @store_balance[attributes['store']] += attributes['value']
        @total_balance += attributes['value']
      else
        @store_balance[attributes['store']] -= attributes['value']
        @total_balance -= attributes['value']
      end

      attributes['balance'] = @store_balance[attributes['store']]

      puts "Atributos: #{attributes}"
      @transactions[transaction.store] << attributes
    end
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # POST /transactions
  # POST /transactions.json
  def create
    file = params[:arquivo].read

    errors = []

    file.each_line.with_index do |line, index|
      begin
        fields = {}

        transaction_type = TransactionType.find_by code: line[0]

        raise "Tipo de transação não encontrada" unless transaction_type

        fields['transaction_type'] = transaction_type
        fields['date'] = "#{line[1..8]}#{line[42..47]}"
        fields['value'] = line[9..18]
        fields['cpf'] = line[19..29]
        fields['card'] = line[30..41]
        fields['store_owner'] = line[48..61].strip
        fields['store'] = line[62..80].strip.delete("\n")
        fields['user_id'] = current_user.id

        @transaction = Transaction.create fields
      rescue Exception => e
        errors << { line: index+1, message: e.message}
      end
    end

    if errors.empty?
      @message_class = 'success'
      @notice_message = 'Arquivo importado com sucesso!'
    else 
      @message_class = 'warning'
      @notice_message = "Arquivo importado com os seguintes erros:<ul>"
        
      errors.each do |error|
        @notice_message += "<li>Linha: #{error[:line]}, Erro: #{error[:message]}</li>"
      end

       @notice_message += "</ul>"
    end

    flash[:notice] = @notice_message
    flash[:notice_class] = @message_class

    redirect_to transactions_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:arquivo)
    end
end
