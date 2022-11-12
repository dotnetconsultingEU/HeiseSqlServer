﻿-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.

-- Thorsten Kansy, www.dotnetconsulting.eu

USE [dotnetconsulting_PartitionDB];
GO

CREATE PARTITION SCHEME ArchivierungPerBuchungsdatum AS PARTITION fnArchivierungPerBuchungsdatum 
TO (
	[FilegroupArchiv1],[FilegroupArchiv2],[FilegroupArchiv3],[FilegroupArchiv4],[FilegroupArchiv5],
	[FilegroupArchiv6],[FilegroupArchiv7],[FilegroupArchiv8],[FilegroupArchiv9],[FilegroupArchiv10], 
	[PRIMARY]);
