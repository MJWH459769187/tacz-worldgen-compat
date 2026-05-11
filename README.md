# TaCZ Worldgen Compat

这是一个用于 Minecraft 1.21.1 NeoForge 的小型兼容补丁，目标是让 TaCZ 1.21.1 非官方移植与 AoA3、Farmer's Delight、Ube's Delight 在同一实例中共存。

## 解决的问题

在以下组合中，创建世界时可能因为 `#c:is_underground` 没有在当前 worldgen registry 加载上下文中绑定而失败：

- Minecraft 1.21.1
- NeoForge 21.1.x
- TaCZ 1.21.1 非官方移植
- GunsmithLib
- Advent of Ascension 3
- Farmer's Delight
- Ube's Delight

典型日志：

```text
Registry loading errors:
>> Errors in element minecraft:worldgen/biome:
java.lang.IllegalStateException: Unbound values in registry ResourceKey[minecraft:root / minecraft:worldgen/biome]: [#c:is_underground]
```

## 补丁方式

本补丁不修改任何原 mod jar。它只作为一个独立低代码 NeoForge mod 覆盖少量 biome modifier JSON，把不稳定的 `#c:is_underground` 引用替换为当前 NeoForge 中等价的原版洞穴生物群系列表：

- `minecraft:lush_caves`
- `minecraft:dripstone_caves`
- `minecraft:deep_dark`

这不是对上游模组的官方修复，只是一个低侵入的兼容绕过方案。

## 当前覆盖

- `data/aoa3/neoforge/biome_modifier/ore_limonite_large.json`
- `data/farmersdelight/neoforge/biome_modifier/wild_potatoes.json`
- `data/farmersdelight/neoforge/biome_modifier/wild_rice.json`
- `data/ubesdelight/neoforge/biome_modifier/wild_garlic.json`
- `data/ubesdelight/neoforge/biome_modifier/wild_ginger.json`
- `data/ubesdelight/neoforge/biome_modifier/wild_lemongrass.json`
- `data/ubesdelight/neoforge/biome_modifier/wild_ube.json`

## 构建

需要本机有 `jar.exe`，通常随 JDK 提供。

```powershell
.\build.ps1
```

输出文件：

```text
dist/zz_tacz_worldgen_compat-1.0.0.jar
```

## 安装

下载或构建 `zz_tacz_worldgen_compat-1.0.0.jar`，然后放入对应实例的 `mods` 文件夹。

当前预构建文件位于：

```text
release/zz_tacz_worldgen_compat-1.0.0.jar
```

## 回退

删除 `zz_tacz_worldgen_compat-1.0.0.jar` 即可，不会影响原 mod 文件。

## 免责声明

本项目与 TaCZ、AoA3、Farmer's Delight、Ube's Delight、NeoForge 官方均无隶属关系。原模组内容和名称归各自作者所有。
