require 'rails_helper'

RSpec.describe FormatsController do
  describe '/create' do
    context 'when given a list of names' do
      let(:names) do
        ['João da Silva Neto', 'João Silva Neto', 'João Neto', 'João da Silva', 'João Silva', 'Joao', 'JOÃO silva']
      end

      it 'prints a list of formatted names' do
        post :create, params: { names: names }

        expect(JSON.parse(response.body)).to eq({
                                                  "formatted_names" => [
                                                    "SILVA NETO, João da",
                                                    "SILVA NETO, João",
                                                    "NETO, João",
                                                    "SILVA, João da",
                                                    "SILVA, João",
                                                    "JOAO",
                                                    "SILVA, João"
                                                  ]
                                                })
      end
    end

    context 'when given invalid parameters' do
      it 'prints invalid message when params is an empty array' do
        post :create, params: { names: [] }

        expect(JSON.parse(response.body)).to eq({ "message" => "invalid params" })
      end

      it 'prints invalid message when params is nil' do
        post :create

        expect(JSON.parse(response.body)).to eq({ "message" => "invalid params" })
      end
    end
  end
end
