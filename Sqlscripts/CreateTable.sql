/****** Object:  Table [asr].[File_config]    Script Date: 3/19/2019 1:51:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [asr].[Filelog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[filename] [varchar](250) NULL,
	[remarks] [varchar](500) NULL
) ON [PRIMARY]
GO

CREATE TABLE [asr].[File_Log_Exception](
	[Exception_id] [int] IDENTITY(1,1) NOT NULL,
	[Filename] [varchar](250) NULL,
	[Exception] [varchar](100) NULL,
	[ADFRunId] [int] NULL
) ON [PRIMARY]
GO

-- Insert config for files 
CREATE TABLE [asr].[File_config](
	[Config_id] [int] IDENTITY(1,1) NOT NULL,
	[Filename] [varchar](250) NULL,
	[Remarks] [varchar](100) NULL
) ON [PRIMARY]
GO