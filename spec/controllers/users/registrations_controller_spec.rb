# frozen_string_literal: true

describe Users::RegistrationsController, type: :controller do
  describe 'GET#new' do
    it 'renders new template' do
      get :new, params: { locale: 'en' }

      expect(response).to render_template :new
    end
  end

  describe 'POST#create' do
    context 'for invalid credentials' do
      let(:request) { post :create, params: { user: { username: '', password: '1' }, locale: 'en' } }

      it 'does not create new user' do
        expect { request }.not_to change(User, :count)
      end

      it 'renders new template' do
        request

        expect(response).to render_template :new
      end
    end

    context 'for short password' do
      let(:request) { post :create, params: { user: { username: 'username', password: '1' }, locale: 'en' } }

      it 'does not create new user' do
        expect { request }.not_to change(User, :count)
      end

      it 'renders new template' do
        request

        expect(response).to render_template :new
      end
    end

    context 'without password confirmation' do
      let(:request) { post :create, params: { user: { username: 'username', password: '12345678' }, locale: 'en' } }

      it 'does not create new user' do
        expect { request }.not_to change(User, :count)
      end

      it 'renders new template' do
        request

        expect(response).to render_template :new
      end
    end

    context 'for existed user' do
      let!(:user) { create :user }
      let(:request) {
        post :create, params: {
          user: { username: user.username, password: '12345678', password_confirmation: '12345678' }, locale: 'en'
        }
      }

      it 'does not create new user' do
        expect { request }.not_to change(User, :count)
      end

      it 'and renders new template' do
        request

        expect(response).to render_template :new
      end
    end

    context 'for valid data' do
      let(:user_params) { { username: 'username', password: '12345678', password_confirmation: '12345678' } }
      let(:request) { post :create, params: { user: user_params, locale: 'en' } }

      it 'creates new user' do
        expect { request }.to change(User, :count).by(1)
      end

      it 'and redirects to home path' do
        request

        expect(response).to redirect_to home_en_path
      end
    end
  end
end
