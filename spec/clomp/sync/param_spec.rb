RSpec.describe Clomp::Sync::Param do
  
  describe 'Validations' do
    class TestParams < Clomp::Sync::Param
      attr_accessor :first_name, :last_name
    
      validates :first_name, :last_name, presence: true
    end
  
    before do
      @param = Clomp::Sync::Param.new(first_name: 'John', last_name: 'Doe')
    end
  
    it 'should set attributes to param' do
      expect(@param.first_name).not_to be 'John'
    end
  
    it 'should validate attributes' do
      @tp = TestParams.new(first_name: 'Irfan', last_name: 'Ahmed')
      expect(@tp.valid?).to be_truthy
    end
  
    it 'should invalidate if not required parameters given' do
      @tp = TestParams.new(first_name: 'Irfan')
      expect(@tp.valid?).to be_falsey
    end
  end
  
  describe 'Block: Setup Params' do
    it 'should return an instance of Clomp::Sync::Param' do
      @form = Clomp::Sync::Param.setup do
        add :title
        add :description
        add :note
        
        validates :title, presence: true
      end
      
      expect(@form).to be_an_instance_of(Clomp::Sync::Param)
      expect(@form).to respond_to(:title)
      expect(@form).to respond_to(:description)
      expect(@form).to respond_to(:note)
      
      expect(@form.title).to be_nil
      expect(@form).not_to be_valid
      expect(@form.errors.messages).to be_empty
    end
  end
end
