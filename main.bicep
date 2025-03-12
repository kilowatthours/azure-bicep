// main bicep template
targetScope = 'resourceGroup'

param location string

type skuType = 'Standard_LRS' | 'Standard_GRS'

param mySkuType skuType
