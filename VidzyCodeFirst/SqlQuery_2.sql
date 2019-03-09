﻿DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'VidzyCodeFirst.Migrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '201903060917451_InitialModel'
BEGIN
    CREATE TABLE [dbo].[Genres] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        CONSTRAINT [PK_dbo.Genres] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[Videos] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        [ReleaseDate] [datetime] NOT NULL,
        CONSTRAINT [PK_dbo.Videos] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[VideoGenres] (
        [Video_Id] [int] NOT NULL,
        [Genre_Id] [int] NOT NULL,
        CONSTRAINT [PK_dbo.VideoGenres] PRIMARY KEY ([Video_Id], [Genre_Id])
    )
    CREATE INDEX [IX_Video_Id] ON [dbo].[VideoGenres]([Video_Id])
    CREATE INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]([Genre_Id])
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id] FOREIGN KEY ([Video_Id]) REFERENCES [dbo].[Videos] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201903060917451_InitialModel', N'VidzyCodeFirst.Migrations.Configuration',  0x1F8B0800000000000400ED59CD6EE33610BE17E83B083AB545D64AB297AD61EF22759222E8260EA224E82D60A4B14394A254920AEC2DFA643DF491FA0A1DEA5FA464C9E9222DDA22406093F33F1F8733F41FBFFD3EFBB08998F30C42D298CFDDA3C9A1EB000FE290F2F5DC4DD5EACD3BF7C3FB2FBF989D85D1C6B92FE9DE6A3AE4E472EE3E29954C3D4F064F1011398968206219AFD42488238F84B1777C78F8AD7774E4018A705196E3CC6E52AE6804D917FCBA887900894A09BB8C4360B258C71D3F93EA5C910864420298BBF734FCB45D20D9391552B9CE09A304ADF081AD5C87701E2BA2D0C6E99D045F8998AFFD041708BBDD2680742BC22414B64F6BF2B16E1C1E6B37BC9AB11415A452C5D19E028FDE1671F14CF61745D7ADE286913BC308ABADF63A8BDEDCFD1EB840CF4D4DD305139ACA8CEC24A33F70DAAB071506102AFAEFC059A44CA502E61C5225083B70AED34746831F607B1BFF047CCE53C69A96A16DB8D75AC0A56B112720D4F6065685BD17A1EB786D3ECF64ACD81A3CB933175CBD3D769D2B544E1E1954896F38EEAB58007A09822808AF895220B8960159E82CED862EFDBFD48648C303E33A9764F311F85A3DCD5DFCE83AE7740361B9525870C7299E2F645222054BC91579A6EBCC3E431DE60162E93A37C0B26DF944931CF6936CEB21CB17129C8B38BA8959C952AC3FDC12B1063C2FB771C7A61FA722308C9979358476022B93B407B032FAFF81F5CAC03294208C804838450B4B5DFAF32DD5BA2DE7C682B4C4E04B415AE2B013A42582C780F444CA38A0990D4D9496FADBEE9CF1D0D9654C9E89CA09CC062293268845D43C77BFB1E2D323B03A82B5C0A228EF1438F31ADED827112F4F452882AD76F453B6081BD5712AF15E2C0EA62C9062DAAE85FAA08C94D6716E9B6EB9DE662FCB96C55E84D2606F786AC8A8A0D320E9829679FE07925BD95B9BEA8D1451A6B321A2B4D12C2F6DB73AF05B25B16E7DBCBCF7297B24AFA7499A5D9224C11AD1689A8A15C7CF3BA6C51B7FFF7622CA657881ECE82A2A6B2B4D58F1C81A8C5D545D9677AC2DE491E852B208238BAC05D91E3C95AA5AA8B43355A2AC24D79F5BE7A2D5DE9802EAE09DA33F11D6EBCC3530536CF365BD2A6144745C1C8B98A511EFBB7C7671E75741933F5FB125CC3CC37033349E151B03A366A447E5A138337F210F791DD83F0F3D7C7F771EFA24B4EEDBA6A0D6C6EBE7B55D993A925BD5DDDD19ACC83AF3D47968745DED6A728D126D8764548273515D69D621A914EF695351F35F685326644F9BCCCBC3CEA2758798241586AABBC4B8336645FD1E9EBEAD829E93B80EDAFE8C81C262EE6FA58268A20926FECF6CC128A2B626B8249CAE40AABC877771083E3686F87FCE40ED4919B23153F5AB4F2154877470CE18EAE3770C1EFC9988E08988AF22B2F9BA29C91E2EF61C14FFD3B11A358885F8590D0F62FBC5FDC540DD51486DE2BE0A379CAF5A4D236BD6F472C143D8CCDD5F32A6A973F1E343C977E02C059697A973E8FCBA77366BB3F7535EF2EDA1FC65136BE765680E26C3A3EA9175072FF9290250817312E45576416440423B62FA82DAA9BD98074D13C64CB8FA45185620F459240CEF31A904DE6456AF732D280F684258CB6BFB321E5341B44B953C73E71412E0BA34D80E8ED1B6ABF7A8441BE11D0A40EF2BC00070BA3A9646EAECAC7526EC5F069CF1A97C5DE0EC6A103F3B70BA9F8FEC917DC4FB50FFF350DE1FE29DF6A8CB535E157B5E493A9F8EFA5F8EBA24773FE1744BEE33BCB9D9ABA3C785C1E7ABEADD69F72B56CFEC63177C6B201E7CBD6AB96D4E68E31FAE46395BBE900D38DB3D54D945CA7A85792D67F778A5B327293CA18D5F3BB14248BAAE45E8DF3E3904ADB359D15CF0555C1609C3A292C468642E41116C1FC9895074450285DB014899FD86704F588A2467D12384177C99AA2455E832448FACF59B842E35BBF4674F916D9B67CB247BEEFF1C2EA0995477C04BFE5D4A5958D97DDED14BF588D035ACE8F5752E95EEF9D7DB4AD255CC470A2AC25795DE5B881286C2E492FBE4195E62DB9D848FB026C1B61C88FB850C27A21DF6D929256B412259C8A8F9F12B62388C36EFFF04B8F086C8F41F0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201903060922022_PopulateGenres'
BEGIN
    INSERT INTO Genres (Name) VALUES ('Genre_1'),('Genre_2'),('Genre_3')
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201903060922022_PopulateGenres', N'VidzyCodeFirst.Migrations.Configuration',  0x1F8B0800000000000400ED59CD6EE33610BE17E83B083AB545D64AB297AD61EF22759222E8260EA224E82D60A4B14394A254920AEC2DFA643DF491FA0A1DEA5FA464C9E9222DDA22406093F33F1F8733F41FBFFD3EFBB08998F30C42D298CFDDA3C9A1EB000FE290F2F5DC4DD5EACD3BF7C3FB2FBF989D85D1C6B92FE9DE6A3AE4E472EE3E29954C3D4F064F1011398968206219AFD42488238F84B1777C78F8AD7774E4018A705196E3CC6E52AE6804D917FCBA887900894A09BB8C4360B258C71D3F93EA5C910864420298BBF734FCB45D20D9391552B9CE09A304ADF081AD5C87701E2BA2D0C6E99D045F8998AFFD041708BBDD2680742BC22414B64F6BF2B16E1C1E6B37BC9AB11415A452C5D19E028FDE1671F14CF61745D7ADE286913BC308ABADF63A8BDEDCFD1EB840CF4D4DD305139ACA8CEC24A33F70DAAB071506102AFAEFC059A44CA502E61C5225083B70AED34746831F607B1BFF047CCE53C69A96A16DB8D75AC0A56B112720D4F6065685BD17A1EB786D3ECF64ACD81A3CB933175CBD3D769D2B544E1E1954896F38EEAB58007A09822808AF895220B8960159E82CED862EFDBFD48648C303E33A9764F311F85A3DCD5DFCE83AE7740361B9525870C7299E2F645222054BC91579A6EBCC3E431DE60162E93A37C0B26DF944931CF6936CEB21CB17129C8B38BA8959C952AC3FDC12B1063C2FB771C7A61FA722308C9979358476022B93B407B032FAFF81F5CAC03294208C804838450B4B5DFAF32DD5BA2DE7C682B4C4E04B415AE2B013A42582C780F444CA38A0990D4D9496FADBEE9CF1D0D9654C9E89CA09CC062293268845D43C77BFB1E2D323B03A82B5C0A228EF1438F31ADED827112F4F452882AD76F453B6081BD5712AF15E2C0EA62C9062DAAE85FAA08C94D6716E9B6EB9DE662FCB96C55E84D2606F786AC8A8A0D320E9829679FE07925BD95B9BEA8D1451A6B321A2B4D12C2F6DB73AF05B25B16E7DBCBCF7297B24AFA7499A5D9224C11AD1689A8A15C7CF3BA6C51B7FFF7622CA657881ECE82A2A6B2B4D58F1C81A8C5D545D9677AC2DE491E852B208238BAC05D91E3C95AA5AA8B43355A2AC24D79F5BE7A2D5DE9802EAE09DA33F11D6EBCC3530536CF365BD2A6144745C1C8B98A511EFBB7C7671E75741933F5FB125CC3CC37033349E151B03A366A447E5A138337F210F791DD83F0F3D7C7F771EFA24B4EEDBA6A0D6C6EBE7B55D993A925BD5DDDD19ACC83AF3D47968745DED6A728D126D8764548273515D69D621A914EF695351F35F685326644F9BCCCBC3CEA2758798241586AABBC4B8336645FD1E9EBEAD829E93B80EDAFE8C81C262EE6FA58268A20926FECF6CC128A2B626B8249CAE40AABC877771083E3686F87FCE40ED4919B23153F5AB4F2154877470CE18EAE3770C1EFC9988E08988AF22B2F9BA29C91E2EF61C14FFD3B11A358885F8590D0F62FBC5FDC540DD51486DE2BE0A379CAF5A4D236BD6F472C143D8CCDD5F32A6A973F1E343C977E02C059697A973E8FCBA77366BB3F7535EF2EDA1FC65136BE765680E26C3A3EA9175072FF9290250817312E45576416440423B62FA82DAA9BD98074D13C64CB8FA45185620F459240CEF31A904DE6456AF732D280F684258CB6BFB321E5341B44B953C73E71412E0BA34D80E8ED1B6ABF7A8441BE11D0A40EF2BC00070BA3A9646EAECAC7526EC5F069CF1A97C5DE0EC6A103F3B70BA9F8FEC917DC4FB50FFF350DE1FE29DF6A8CB535E157B5E493A9F8EFA5F8EBA24773FE1744BEE33BCB9D9ABA3C785C1E7ABEADD69F72B56CFEC63177C6B201E7CBD6AB96D4E68E31FAE46395BBE900D38DB3D54D945CA7A85792D67F778A5B327293CA18D5F3BB14248BAAE45E8DF3E3904ADB359D15CF0555C1609C3A292C468642E41116C1FC9895074450285DB014899FD86704F588A2467D12384177C99AA2455E832448FACF59B842E35BBF4674F916D9B67CB247BEEFF1C2EA0995477C04BFE5D4A5958D97DDED14BF588D035ACE8F5752E95EEF9D7DB4AD255CC470A2AC25795DE5B881286C2E492FBE4195E62DB9D848FB026C1B61C88FB850C27A21DF6D929256B412259C8A8F9F12B62388C36EFFF04B8F086C8F41F0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201903061537539_ConvertManyToManyToOneToManyRelationVideoGenre'
BEGIN
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Videos_Video_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id]
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Genres_Genre_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Video_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Video_Id] ON [dbo].[VideoGenres]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Genre_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]
    ALTER TABLE [dbo].[Videos] ADD [Genre_Id] [int]
    CREATE INDEX [IX_Genre_Id] ON [dbo].[Videos]([Genre_Id])
    ALTER TABLE [dbo].[Videos] ADD CONSTRAINT [FK_dbo.Videos_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id])
    DROP TABLE [dbo].[VideoGenres]
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201903061537539_ConvertManyToManyToOneToManyRelationVideoGenre', N'VidzyCodeFirst.Migrations.Configuration',  0x1F8B0800000000000400ED59DB6EE336107D2FD07F20F4D416592BC9BEB486BD8BD4490AA39B0BA224E85B404B63872845A92415D85BF4CBFAD04FEA2F74A89B2552B6656F372DD02240E0903367AE9C8BF3E7EF7F8CDE2F634E5E402A9688B1773238F60888308998588CBD4CCFDF7CEBBD7FF7E517A38B285E92C78AEEADA1434EA1C6DEB3D6E9D0F755F80C31558398853251C95C0FC224F66994F8A7C7C7DFF927273E20848758848CEE32A1590CF91FF8E7241121A43AA3FC2A8980ABF21C6F821C955CD318544A43187B8F2CFAB89A20D925934A7BE48C338A5A04C0E71EA142249A6AD471F8A020D032118B20C503CAEF572920DD9C7205A5EEC335795F338E4F8D19FE9AB1820A33A593784FC093B7A55F7C9BFD20EF7AB5DFD07317E861BD3256E7DE1B7B3F809068B92D6938E1D250D99E1DE4F447A47D7A54E700A68AF93922938CEB4CC25840A625E547E4369B7116FE08ABFBE46710639171DED40C75C3BBD6011EDDCA2405A95777302FF59D461EF1DB7CBECD58B335780A63A642BF3DF5C8350AA7330E75E01B86073A91805682A41AA25BAA3548613020779D23DD92657E57D230D3F0C178E48A2E3F8058E8E7B1871F3D72C996105527A5060F82E1FB42262D33680B19F9EBA86D8D250605923D6299D3FF1FCBD78CA52BE40E385005E7A86125CB7CBE6746B6639C85754D5FD822B7D5422D9F3582E7B7EA99A545352C82FE54DE5FCA24BE4B78953BC5F15390643234DA24EEDD3D950BD0FD12F44CA92464B902CD0C2D85B72DB91011D9A24911835A7F8C03E6244B310B51EED8FBC6F14C375EA57D03AFF4441BEF783038B16D6C58E3BE42EC559A324CB4B5A11FF34358EA8E17896DA87C94AACC125B7B031A806E86537964EDE7B6F68EF16DF6DC055DECA5332DF686A5164695370D8A8EB4B25FFEF6D8D6CAAEF5F4FB2154D16C20548EB2CB4ADBA48EDCAD03B89E32FC62CCA8C6117FC33C32BAA2698AB5A1319F942724288693C99B60FFCE1D17187EA83A1A78AD6D2D092B1D5D80758BA2ABB28E3585CEA82921932876C85AE9BA21972A51AD8C7403556558456E3EB7DE446B92B001D6CEBB447B62ACD3B9696087D8E5CBC742CAA9EC6818938467B1D8D474B671172DA0C95F9CB80823DF52DC768DEFF8C6CA51DBD3BDE2503E994F88435103F68FC306BE7F3A0E9B105A7DB609D4BA78FDB8B62B534770AB9ABB3D801555AF28997A6AB9A7A3AEBAAEE815D802A32BBCC615B5DCFD542A9BC5812AEDAD0C96C288E573CB549919AC9EBFFA186A771B37EC4ED3B149EAA4AB9B8FD5644665C1DFBD193B1DA020F108DAFE821EC6EA1FAC948678600806C12F7CC219A6F99AE08A0A3607A58B61DFC305F5D45AB0FF3DCBAEAF54C4FB6CBCAFBEAE30E3D29D0BC9AE817FCB86225EA80C9FA9FC2AA6CBAF9B489FBC51FEA77DD56B638BF0B3EEB5B175ED694F96E5CEBA3015112CC7DEAF39D3904C7F7AAAF88EC88DC4273A24C7E4B7C3627ED892D6E849FBED51EE307FC876878906D2E401E55843959658459DC67C8B1B7BC852CA5B3ABB2DA44FF61AFFD578F6CD39A4204C5AB6CCEA23685BAFAC51AD67B4CBF63D37557743E8B18A6EDE448BEE822F6266025B24E386A5AC734BDDBCA47621772F8C9F71816D59DF584776AEACEE9EFB799654772EC08C697CAF8EC9AAD8620D61461D01612B576A9AA9982755D25A1A5524563DBB024DB118D233A9D99C861AAF43502AFFEAEC91F20C492EE21944537193E934D36832C433DEFA2ACEA4FE36F9F926DED6797493E65F73FD1D26A09ACCD4F31BF17DC67854EB7DE9D6F34D10E64D959DCBC4529B0EB658D548D789E80954BAAF2E05F710A71CC1D48D08E80B1CA2DB83820FB0A0E1AA1AEF3683EC0E44DBEDA373461792C6AAC458F39BFF15F9E69F45EFFE0268FE154F5E1A0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201903061540058_AddClasificationToVideosTable'
BEGIN
    ALTER TABLE [dbo].[Videos] ADD [Classification] [tinyint] NOT NULL DEFAULT 0
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201903061540058_AddClasificationToVideosTable', N'VidzyCodeFirst.Migrations.Configuration',  0x1F8B0800000000000400ED595B6FDB36147E1FB0FF20E8691B52CB4E5EB6C06ED1BA4961AC4E82282DF656D0D2B1438CA234920AEC0DFB657BD84FDA5FD8A1EE2465474E2F1BB0A140619187E7FAF15C98BFFEF873FA629B30EF0184A4299FF993D1D8F78047694CF966E6E76AFDEC7BFFC5F3AFBF9A5EC4C9D67B5FD39D693A3CC9E5CCBF572A3B0F0219DD4342E428A1914865BA56A3284D0212A7C1E978FC43309904802C7CE4E579D3DB9C2B9A40F1819FF3944790A99CB0651A0393D53AEE840557EF8A24203312C1CC7F4FE35F777324BBA4422ADF7BC928412D42606BDF239CA78A28D4F1FC9D845089946FC20C1708BBDB6580746BC22454BA9FB7E443CD189F6A3382F660CD2ACAA54A9323194ECE2ABF04F6F12779D76FFC869EBB400FAB9DB6BAF0DECC7F035CA0E5B6A4F339139ACAF6ECA8A03FF1CCD59306030815FDEFC49BE74CE502661C7225083BF16EF215A3D18FB0BB4B7F063EE339635DCD5037DC331670E946A41908B5BB8575A5EF22F6BDC03C17D8079B639D33A5310BAECE4E7DEF0A8593158326F01DC343950A402B411005F10D510A04D73CA0709D23DD92A5FFAFA521D2F0C2F8DE926CDF02DFA8FB998F3F7DEF926E21AE572A0DDE718AF70B0F29918329641AB4513B184B0C0AA447C4B2A0FF3F965F3296AE905B604024BC460D6B59FAF71DD5B21DE30EF39A3322255DD3A8CA1695EA980447F6D6639CAFC803DD14B4968C2A61A0DAC5AEBCA75925A280D3876AFF52A4C96DCA6A5496CB1FC2341791B63375F7EE88D8801A0AFD3CE900DF366E212F19D9B4797DF08D30197DAAAB81808841B01D02A894FA6A87C136FDBD846405A2B227A40C8BAFEFBD272CC7CF89131D83FA4DCAE286F6F430ED8D8E1A3AAFA13F731D5EBAB6BBF852CA34A2854FBAA9A68AB529EE82C7DE81C0B788ACB2D5123D4833F4198679E67FE7A8DFCFAF064B875F053C93DF78349AD81676AC71D329361D8A50DE38AC420057B0553D40C27EA2C292ACAEBBADBD661A82EADE1EE97B2DAC4DED1DE3CDE3850BFA8E57CEB48E772CB578D4D7B443D1738BED147E38B68DB2AD9EC1300E75343B1C6A47D9F5C134A9275534016CDBC5A0EC17EBBE32D8D3584E9724CBF08E761ACD6AC50BCB2E73FE2C3CBE054B4A1E41247B3AB146DB4612962CB2016B1745D749088B0359119DD5E671E2901970DD83A55A948148375035C26A72FDDBB813464B6833689D7789F62458700BD3C00EB17BAEE8EF0923A2A7F2CF5396277C5FF770E87459CBBBE7CB1597C334B014B75D1338BEB1306A7B7A501CAA2BF311712873C0F171D873EE9F8EC33E0E46C3D465646C0CE767370F5D96F6DE97478B99EF7A205367F2C3B0A8A906C55E6769CB493DD9DA75C520B8943CFA40A35DD1C83D4EA5AA043D51A5A395C1041BD3A21B5A48DD48378DE61043ED1AE686DD2965364903BAA6A459A56B5A9591C71F4E9CBA5292F81EDAFE801EC69A12EEA48264A40946E12F6CCE28C2BC2558124ED72055D9F0FAA7E3C9A9F5FEF2EF790B09A48CD99007912F3ECD52EDD247E7D523E7C1EE00CB1F8888EE89F82621DB6FBB9C3EFAC1E13FEDAB41037D8CBFD5A71BE87182DB153E38925B9B913A7E74469A050EABDB99FF5B71E8DC5BFCF4A13E77E25D0BBCF0E7DED8FBFD69087ADA20D9A970C7CD7AEEC0F1940914610B42A38A30CCC812E77CEA96F91B41794433C20C9DDD8234E42E68FF35FCEC9DD79001D72037CC1A22E850E56DB85A97F231DB8F9CA6DD2966C0B8BC7F5A2E6B15DEAF950E6C09C63D8363EF24BD7F90EEE3DC3FD47EC621DBB0BE33323D3A56BBB3F8E719A4DD2E0311D3F9230E8255D24DCB42374E1C22032B0DCD82AFD31AB49646358995CF96A008A656F25228BA2691C2ED08305FEA77DAEA79EB225941BCE0D7B9CA72852643B262C6BBAF86FE21F9C56B81A9F3F43A2B5E3E3F8509A826D5D5E19ABFCA69E719EFD2CDE7FB58E83B55D5411D4BA5EBE166D770BA4AF9404695FB9A54700749C69099BCE6217980A7E8F64EC25BD8906857378BFB993C1E08D3EDD3D7946C044964C5A33D8F9F88E138D93EFF1BB234548ACB1C0000 , N'6.2.0-61023')
END

