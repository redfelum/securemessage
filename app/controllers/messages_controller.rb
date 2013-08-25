# coding: utf-8
require 'openssl'
class MessagesController < ApplicationController
  include MessagesHelper
  @@isAuth=false
  @@msg=""

  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  def validate
    render "validate_pass"
  end

  def validate_pass
    begin
      @pass=params[:pass]
      @message = Message.where(short_url: params[:id]).first
      @@msg=Message.decrupt_message(@message.message_text, @pass)
      @@isAuth=true
      redirect_to root_url.to_s+@message.short_url
    rescue OpenSSL::Cipher::CipherError
      flash[:notice] = "Введен неверный пароль"
      redirect_to :controller => 'messages', :action => 'validate', :id => params[:id]
      @@isAuth=false
    end
  end

  def show
    if !@@isAuth
      redirect_to :controller => 'messages', :action => 'validate', :id => params[:id]
    else
     msg= init_msg(@@msg)
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: init_msg(msg) }
        @@isAuth=false
      end
    end

  end

  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  def create
    @message = Message.new(params[:message])
    @message.set_password(params[:pass_id])
    respond_to do |format|
      if @message.save
        format.html { redirect_to "/messages/done/"+@message.id.to_s }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def done
    @message = Message.where(id: params[:id]).first
  end


end
