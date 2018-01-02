{
  "targets": [
    {
      "target_name": "addon",
      "sources": [ "src/index.cc" ],
      "include_dirs": [
        "<!(node -e \"require('nan')\")",
      ],
      "conditions": [
        ['OS=="mac"', {
          "sources": [ "src/mac.mm" ]
        }],
        ['OS!="mac"', {
          "sources": [ "src/default.cc" ]
        }]
      ]
    }
  ]
}
