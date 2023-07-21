require "./lib/chord_fingering"

RSpec.describe ChordFingering do
  describe ".generate" do
    it "returns the fingering for a root chord" do
      expect(described_class.generate("A")).to eq "x02220"
    end

    it "decrements the third for a minor chord" do
      expect(described_class.generate("Am")).to eq "x02210"
    end

    it "returns the fingering for a D minor chord" do
      expect(described_class.generate("Dm")).to eq "xx0231"
    end

    it "doesn't decrement a value to below 0" do
      expect(described_class.generate("A7")).to eq "x02020"
    end
  end
end