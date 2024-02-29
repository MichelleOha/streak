class PaymentsController < ApplicationController
  def index
    render json: Payment.all
  end

  def create
    payment = Payment.new(payment_params)

    if payment.save
      render json: payment, status: :created
    else
      render json: payment.errors, status: unprocessable_entity 
    end

    def show payment = Payment.find(params[:id])
      render json: payment, status: :ok 
    rescue ActiveRecord::RecordNotFound 
      render json: { error: 'Payment not found' }, status: :not_found 
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :description, :id)
  end
end
