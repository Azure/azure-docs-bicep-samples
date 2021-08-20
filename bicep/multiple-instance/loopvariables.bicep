var disks_top_level_array = [for i in range(0, 5): {
  name: 'myDataDisk${(i + 1)}'
  diskSizeGB: '1'
  diskIndex: i
}]

output exampleArray array = disks_top_level_array
