return {
  name = "shiranuit/terra-luvit",
  version = "2.18.1",
  luvi = {
    version = "2.12.0",
    flavor = "regular",
  },
  license = "Apache 2",
  homepage = "https://github.com/shiranuit/terra-luvit",
  description = "node.js style APIs for luvi as either a luvi app or library.",
  tags = { "terra", "luvit", "meta" },
  author = { name = "Shiranuit" },
  contributors = {
    "Tim Caswell",
    "Ryan Phillips",
    "George Zhao",
    "Rob Emanuele",
    "Daniel Barney",
    "Ryan Liptak",
    "Kenneth Wilke",
    "Gabriel Nicolas Avellaneda",
  },
  dependencies = {
  },
  files = {
    "*.lua",
    "*.t",
    "terra.so",
    "!examples",
    "!tests",
    "!bench",
    "!lit-*",
  }
}
