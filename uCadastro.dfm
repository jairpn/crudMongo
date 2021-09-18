object frmCadastro: TfrmCadastro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 333
  ClientWidth = 904
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblMongo: TLabel
    Left = 112
    Top = 8
    Width = 57
    Height = 23
    Caption = 'Mongo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 672
    Top = 8
    Width = 65
    Height = 23
    Caption = 'MS SQL'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 429
    Top = 40
    Width = 457
    Height = 206
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'AddressLine1'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'City'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PostalCode'
        Width = 100
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 40
    Width = 415
    Height = 206
    DataSource = DataSource2
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 275
    Width = 904
    Height = 58
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 288
    object btnDeleteMongo: TButton
      Left = 16
      Top = 17
      Width = 107
      Height = 25
      Caption = 'Delete Mongo'
      TabOrder = 0
      OnClick = btnDeleteMongoClick
    end
    object btnInsertMongo: TButton
      Left = 171
      Top = 17
      Width = 107
      Height = 25
      Caption = 'Insert Mongo'
      TabOrder = 1
      OnClick = btnInsertMongoClick
    end
    object btnUpdateMongo: TButton
      Left = 326
      Top = 17
      Width = 107
      Height = 25
      Caption = 'Update Mongo'
      TabOrder = 2
      OnClick = btnUpdateMongoClick
    end
    object btnSelectMongo: TButton
      Left = 481
      Top = 17
      Width = 107
      Height = 25
      Caption = 'Abrir Mongo'
      TabOrder = 3
      OnClick = btnSelectMongoClick
    end
    object btnAbrirMssql: TButton
      Left = 636
      Top = 17
      Width = 107
      Height = 25
      Caption = 'Abrir Mssql'
      TabOrder = 4
      OnClick = btnAbrirMssqlClick
    end
    object btnFechar: TButton
      Left = 792
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 5
      OnClick = btnFecharClick
    end
  end
  object FDQuery1: TFDQuery
    Connection = fdConexaoMssql
    SQL.Strings = (
      'SELECT top (20) *  FROM '
      '[AdventureWorks2019].[Person].[Address] '
      'ORDER BY  ModifiedDate asc')
    Left = 432
    Top = 128
    object FDQuery1AddressID: TFDAutoIncField
      FieldName = 'AddressID'
      Origin = 'AddressID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery1AddressLine1: TWideStringField
      FieldName = 'AddressLine1'
      Origin = 'AddressLine1'
      Required = True
      Size = 60
    end
    object FDQuery1AddressLine2: TWideStringField
      FieldName = 'AddressLine2'
      Origin = 'AddressLine2'
      Size = 60
    end
    object FDQuery1City: TWideStringField
      FieldName = 'City'
      Origin = 'City'
      Required = True
      Size = 30
    end
    object FDQuery1StateProvinceID: TIntegerField
      FieldName = 'StateProvinceID'
      Origin = 'StateProvinceID'
      Required = True
    end
    object FDQuery1PostalCode: TWideStringField
      FieldName = 'PostalCode'
      Origin = 'PostalCode'
      Required = True
      Size = 15
    end
    object FDQuery1SpatialLocation: TBlobField
      FieldName = 'SpatialLocation'
      Origin = 'SpatialLocation'
    end
    object FDQuery1rowguid: TGuidField
      FieldName = 'rowguid'
      Origin = 'rowguid'
      Required = True
      Size = 38
    end
    object FDQuery1ModifiedDate: TSQLTimeStampField
      FieldName = 'ModifiedDate'
      Origin = 'ModifiedDate'
      Required = True
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 536
    Top = 128
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Server=192.168.1.140'
      'DriverID=Mongo')
    Left = 48
    Top = 16
  end
  object fdConexaoMssql: TFDConnection
    Params.Strings = (
      'User_Name=sa'
      'Password=J@pa0101'
      'Address=192.168.1.140'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 440
    Top = 56
  end
  object FDMongoDataSet1: TFDMongoDataSet
    Connection = FDConnection1
    Left = 96
    Top = 136
  end
  object DataSource2: TDataSource
    DataSet = FDMongoDataSet1
    Left = 192
    Top = 136
  end
end
