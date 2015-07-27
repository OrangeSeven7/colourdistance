require 'spec_helper'

describe "Colourdistance" do
  it "correct ciede2000 bottom bounds" do
    expect(0.000).to eq Colourdistance.ciede2000({r: 0.0, g: 0.0, b: 0.0},{r: 0.0, g: 0.0, b: 0.0}).round(3)
  end

  it "correct ciede2000 sample" do
    expect(0.230).to eq Colourdistance.ciede2000({r:233.0, g: 227.0, b: 203.0},{r: 228.0, g: 172.0, b: 56.0}).round(3)
  end

	it "correct ciede2000 top bounds" do
    expect(1.000).to eq Colourdistance.ciede2000({r: 0.0, g: 0.0, b: 0.0},{r: 255.0, g: 255.0, b: 255.0}).round(3)
  end

  it "correct cie76 bottom bounds" do
    expect(0.000).to eq Colourdistance.cie76({r: 0.0, g: 0.0, b: 0.0},{r: 0.0, g: 0.0, b: 0.0}).round(3)
  end

  it "correct cie76 top bounds" do
    expect(1.000).to eq Colourdistance.cie76({r: 0.0, g: 0.0, b: 0.0},{r: 255.0, g: 255.0, b: 255.0}).round(3)
  end

  it "correct cie94 bottom bounds" do
    expect(0.000).to eq Colourdistance.cie94({r: 0.0, g: 0.0, b: 0.0},{r: 0.0, g: 0.0, b: 0.0}).round(3)
  end

  it "correct cie94 top bounds" do
    expect(1.000).to eq Colourdistance.cie94({r: 0.0, g: 0.0, b: 0.0},{r: 255.0, g: 255.0, b: 255.0}).round(3)
  end
end