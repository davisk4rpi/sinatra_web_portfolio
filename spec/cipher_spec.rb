require "caesar"

describe "#caesar_cipher" do 
	context "given a string and number" do
		context "given \"string!\",1" do
			it "returns \"tusjoh!\"" do
				expect(caesar_cipher("string!", 1)).to eql("tusjoh!")
			end
		end
		context "given \"Zebra\",3" do
			it "returns \"Cheud\"" do
				expect(caesar_cipher("The Zebra", 3)).to eql("Wkh Cheud")
			end
		end
	end
end