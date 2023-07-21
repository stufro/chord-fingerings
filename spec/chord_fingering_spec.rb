require "./lib/chord_fingering"

RSpec.describe ChordFingering do
  describe ".generate" do
    it "returns the fingering for a root chord" do
      expect(described_class.generate("A")).to eq "x02220"
    end

    it "decrements the third for a minor chord" do
      expect(described_class.generate("Am")).to eq "x02210"
    end

    it "increments the third for a sus4 chord" do
      expect(described_class.generate("Bsus4")).to eq "x24452"
    end

    it "decrements the third for a sus2 chord" do
      expect(described_class.generate("Csus2")).to eq "x30010"
    end

    it "increments the fifth for an augmented chord" do
      expect(described_class.generate("Daug")).to eq "xx0332"
    end

    it "decrements the fifth for a diminished chord" do
      expect(described_class.generate("Edim")).to eq "012100"
    end

    it "decrements the root for a 7 chord" do
      expect(described_class.generate("F7")).to eq "131211"
    end

    it "doesn't decrement a root below 0" do
      expect(described_class.generate("A7")).to eq "x02020"
    end
  end
end