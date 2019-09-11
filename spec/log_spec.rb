require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'ProgressBar bar log output' do
  before do
    Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 0)
    @progress_bar = ProgressBar.new(100)
    @progress_bar.stub(:terminal_width) { 60 }
    @progress_bar.count = 100
    Timecop.freeze Time.utc(2010, 3, 10, 0, 0, 10) # 10 seconds later
  end

  context 'with a normal log message' do
    before do
      @message = "The ships hung in the sky in much the same way that bricks don't."

      @expected_s = @message +
        "\n[##############] [100/100] [100%] [00:10] [00:00] [ 10.00/s]"
    end

    it 'should log the message above the bar' do
      @progress_bar.log_s(@message) == @expected_s
    end
  end

  context 'with a very long log message' do
    before do
      @message = "The Babel fish, said The Hitchhiker's Guide to the Galaxy quietly, is small, yellow and leech-like, and probably the oddest thing in the Universe. It feeds on brainwave energy received not from its own carrier but from those around it. It absorbs all unconscious mental frequencies from this brainwave energy to nourish itself with. It then excretes into the mind of its carrier a telepathic matrix formed by combining the conscious thought frequencies with nerve signals picked up from the speech centres of the brain which has supplied them. The practical upshot of all this is that if you stick a Babel fish in your ear you can instantly understand anything in any form of language. The speech patterns you actually hear decode the brainwave matrix which has been fed into your mind by your Babel fish.
        Now it is such a bizarrely improbable coincidence that anything so mindbogglingly useful could have evolved purely by chance that some thinkers have chosen to see it as the final and clinching proof of the non-existence of God.
        The argument goes something like this: 'I refuse to prove that I exist,' says God, 'for proof denies faith, and without faith I am nothing.'
        'But,' says Man, 'the Babel fish is a dead giveaway, isn't it? It could not have evolved by chance. It proves you exist, and so therefore, by your own arguments, you don't. QED.'
        'Oh dear,' says God, 'I hadn't thought of that,' and promptly vanishes in a puff of logic.
        'Oh, that was easy,' says Man, and for an encore goes on to prove that black is white and gets himself killed on the next zebra crossing.
        Most leading theologians claim that this argument is a load of dingo's kidneys, but that didn't stop Oolon Colluphid making a small fortune when he used it as the central theme of his bestselling book, Well That about Wraps It Up for God.
        Meanwhile, the poor Babel fish, by effectively removing all barriers to communication between different races and cultures, has caused more and bloodier wars than anything else in the history of creation."

      @expected_s = @message +
        "\n[##############] [100/100] [100%] [00:10] [00:00] [ 10.00/s]"
    end

    it 'should log the message above the bar' do
      @progress_bar.log_s(@message) == @expected_s
    end
  end

  context 'with a log message containing new lines' do
    before do
      @message = "Time is an illusion. Lunchtime doubly so.\n
        Very deep, said Arthur, you should send that in to the Reader's Digest.\n
        They've got a page for people like you."

      @expected_s = @message +
        "\n[##############] [100/100] [100%] [00:10] [00:00] [ 10.00/s]"
    end

    it 'should log the message above the bar' do
      @progress_bar.log_s(@message) == @expected_s
    end
  end
end
