require "guard/compat/test/helper"
require "guard/nanoc"


RSpec.describe Guard::Nanoc do
  let!(:site) { instance_double(Nanoc::Site) }

  let(:site_class) { class_double(Nanoc::Site) }

  before do
    allow(Process).to receive(:fork) do |_args, &block|
      @_fork_block = block
    end

    allow(Process).to receive(:waitpid) do
      @_fork_block.call
    end

    allow(Guard::Compat::UI).to receive(:notify)
    allow(Guard::Compat::UI).to receive(:error)
    allow(Guard::Compat::UI).to receive(:info)

    stub_const("Nanoc::Site", site_class)
    allow(site_class).to receive(:new).and_return(site)

    allow(site).to receive(:compile)
    allow(site).to receive(:config).and_return({})
    allow($stderr).to receive(:puts)
  end

  describe "#start" do
    context "with no errors" do
      it "outputs success" do
        expect(Guard::Compat::UI).to receive(:info).with(/Compilation succeeded/)
        subject.start
      end

      it "notifies about success" do
        expect(Guard::Compat::UI).to receive(:notify).with(/Compilation succeeded/, anything)
        subject.start
      end
    end

    context "with errors" do
      before do
        allow(site).to receive(:compile).and_raise(::Nanoc::Errors::GenericTrivial)
      end

      it "outputs failure" do
        expect(Guard::Compat::UI).to receive(:error).with(/Compilation failed/)
        subject.start
      end

      it "notifies about failure" do
        expect(Guard::Compat::UI).to receive(:notify).with(/Compilation FAILED/, anything)
        subject.start
      end
    end
  end
end
