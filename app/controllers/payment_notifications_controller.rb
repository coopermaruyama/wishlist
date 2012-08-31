class PaymentNotificationsController < ApplicationController
	protect_from_forgery :except => [:create]
  def create
    @payment_notification = PaymentNotification.create!(:params => params, :list_id => params[:custom], :amount => params[:payment_gross], :status => params[:payment_status], :transaction_id => params[:txn_id])
    render :nothing => true
  end
end
