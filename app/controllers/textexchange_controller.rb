class TextexchangeController < ApplicationController
  def text_delegate
    welcome
  end

  def welcome
    if params[:From].any?
    @client.messages.create(
      from: '+13479831841',
      to: params[:From],
      body: 'THIS IS A WELCOME. CALL ME TO RECORD!'
    )
  end

  def follow_up_questions
  end
end
