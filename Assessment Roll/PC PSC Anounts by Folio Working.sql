SELECT [FACT].[dimFolio_SK], [FACT].[dimRollYear_SK],
       [Gen Gross Land PC 01] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '01'
                                        THEN [Gross General Land Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Impr PC 01] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '01'
                                        THEN [Gross General Building Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Total PC 01] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '01'
                                         THEN [Gross General Total Value]
                                         ELSE 0
                                     END), 
       [Sch Gross Land PC 01] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '01'
                                        THEN [Gross School Land Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Impr PC 01] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '01'
                                        THEN [Gross School Building Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Total PC 01] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '01'
                                         THEN [Gross School Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Gross Land PC 01] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '01'
                                          THEN [Gross Other Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Impr PC 01] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '01'
                                          THEN [Gross Other Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Total PC 01] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '01'
                                           THEN [Gross Other Total Value]
                                           ELSE 0
                                       END), 
       [Gen Exmpt Land PC 01] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '01'
                                        THEN [General Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Impr PC 01] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '01'
                                        THEN [General Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Total PC 01] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '01'
                                         THEN [General Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Sch Exmpt Land PC 01] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '01'
                                        THEN [School Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Impr PC 01] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '01'
                                        THEN [School Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Total PC 01] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '01'
                                         THEN [School Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Exmpt Land PC 01] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '01'
                                          THEN [Other Exemptions Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Impr PC 01] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '01'
                                          THEN [Other Exemptions Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Total PC 01] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '01'
                                           THEN [Other Exemptions Total Value]
                                           ELSE 0
                                       END), 
       [Gen Net Land PC 01] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '01'
                                      THEN [Net General Land Value]
                                      ELSE 0
                                  END), 
       [Gen Net Impr PC 01] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '01'
                                      THEN [Net General Building Value]
                                      ELSE 0
                                  END), 
       [Gen Net Total PC 01] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '01'
                                       THEN [Net General Total Value]
                                       ELSE 0
                                   END), 
       [Sch Net Land PC 01] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '01'
                                      THEN [Net School Land Value]
                                      ELSE 0
                                  END), 
       [Sch Net Impr PC 01] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '01'
                                      THEN [Net School Building Value]
                                      ELSE 0
                                  END), 
       [Sch Net Total PC 01] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '01'
                                       THEN [Net School Total Value]
                                       ELSE 0
                                   END), 
       [Hsptl Net Land PC 01] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '01'
                                        THEN [Net Other Land Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Impr PC 01] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '01'
                                        THEN [Net Other Building Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Total PC 01] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '01'
                                         THEN [Net Other Total Value]
                                         ELSE 0
                                     END), 
       [Gen Gross Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross General Land Value], 0)), 
       [Gen Gross Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross General Building Value], 0)), 
       [Gen Gross Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross General Total Value], 0)), 
       [Sch Gross Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross School Land Value], 0)), 
       [Sch Gross Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross School Building Value], 0)), 
       [Sch Gross Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross School Total Value], 0)), 
       [Hsptl Gross Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross Other Land Value], 0)), 
       [Hsptl Gross Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross Other Building Value], 0)), 
       [Hsptl Gross Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross Other Total Value], 0)), 
       [Gen Exmpt Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [General Exemptions Land Value], 0)), 
       [Gen Exmpt Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [General Exemptions Building Value], 0)), 
       [Gen Exmpt Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [General Exemptions Total Value], 0)), 
       [Sch Exmpt Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [School Exemptions Land Value], 0)), 
       [Sch Exmpt Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [School Exemptions Building Value], 0)), 
       [Sch Exmpt Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [School Exemptions Total Value], 0)), 
       [Hsptl Exmpt Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Other Exemptions Land Value], 0)), 
       [Hsptl Exmpt Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Other Exemptions Building Value], 0)), 
       [Hsptl Exmpt Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Other Exemptions Total Value], 0)), 
       [Gen Net Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net General Land Value], 0)), 
       [Gen Net Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net General Building Value], 0)), 
       [Gen Net Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net General Total Value], 0)), 
       [Sch Net Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net School Land Value], 0)), 
       [Sch Net Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net School Building Value], 0)), 
       [Sch Net Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net School Total Value], 0)), 
       [Hsptl Net Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net Other Land Value], 0)), 
       [Hsptl Net Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net School Building Value], 0)), 
       [Hsptl Net Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net School Total Value], 0)), 
       [Gen Gross Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross General Land Value], 0)), 
       [Gen Gross Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross General Building Value], 0)), 
       [Gen Gross Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross General Total Value], 0)), 
       [Sch Gross Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross School Land Value], 0)), 
       [Sch Gross Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross School Building Value], 0)), 
       [Sch Gross Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross School Total Value], 0)), 
       [Hsptl Gross Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross Other Land Value], 0)), 
       [Hsptl Gross Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross Other Building Value], 0)), 
       [Hsptl Gross Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross Other Total Value], 0)), 
       [Gen Exmpt Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [General Exemptions Land Value], 0)), 
       [Gen Exmpt Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [General Exemptions Building Value], 0)), 
       [Gen Exmpt Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [General Exemptions Total Value], 0)), 
       [Sch Exmpt Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [School Exemptions Land Value], 0)), 
       [Sch Exmpt Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [School Exemptions Building Value], 0)), 
       [Sch Exmpt Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [School Exemptions Total Value], 0)), 
       [Hsptl Exmpt Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Other Exemptions Land Value], 0)), 
       [Hsptl Exmpt Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Other Exemptions Building Value], 0)), 
       [Hsptl Exmpt Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Other Exemptions Total Value], 0)), 
       [Gen Net Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net General Land Value], 0)), 
       [Gen Net Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net General Building Value], 0)), 
       [Gen Net Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net General Total Value], 0)), 
       [Sch Net Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net School Land Value], 0)), 
       [Sch Net Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net School Building Value], 0)), 
       [Sch Net Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net School Total Value], 0)), 
       [Hsptl Net Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net Other Land Value], 0)), 
       [Hsptl Net Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net School Building Value], 0)), 
       [Hsptl Net Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net School Total Value], 0)), 
       [Gen Gross Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross General Land Value], 0)), 
       [Gen Gross Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross General Building Value], 0)), 
       [Gen Gross Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross General Total Value], 0)), 
       [Sch Gross Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross School Land Value], 0)), 
       [Sch Gross Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross School Building Value], 0)), 
       [Sch Gross Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross School Total Value], 0)), 
       [Hsptl Gross Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross Other Land Value], 0)), 
       [Hsptl Gross Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross Other Building Value], 0)), 
       [Hsptl Gross Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross Other Total Value], 0)), 
       [Gen Exmpt Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [General Exemptions Land Value], 0)), 
       [Gen Exmpt Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [General Exemptions Building Value], 0)), 
       [Gen Exmpt Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [General Exemptions Total Value], 0)), 
       [Sch Exmpt Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [School Exemptions Land Value], 0)), 
       [Sch Exmpt Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [School Exemptions Building Value], 0)), 
       [Sch Exmpt Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [School Exemptions Total Value], 0)), 
       [Hsptl Exmpt Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Other Exemptions Land Value], 0)), 
       [Hsptl Exmpt Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Other Exemptions Building Value], 0)), 
       [Hsptl Exmpt Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Other Exemptions Total Value], 0)), 
       [Gen Net Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net General Land Value], 0)), 
       [Gen Net Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net General Building Value], 0)), 
       [Gen Net Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net General Total Value], 0)), 
       [Sch Net Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net School Land Value], 0)), 
       [Sch Net Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net School Building Value], 0)), 
       [Sch Net Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net School Total Value], 0)), 
       [Hsptl Net Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net Other Land Value], 0)), 
       [Hsptl Net Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net School Building Value], 0)), 
       [Hsptl Net Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net School Total Value], 0)), 
       [Gen Gross Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross General Land Value], 0)), 
       [Gen Gross Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross General Building Value], 0)), 
       [Gen Gross Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross General Total Value], 0)), 
       [Sch Gross Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross School Land Value], 0)), 
       [Sch Gross Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross School Building Value], 0)), 
       [Sch Gross Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross School Total Value], 0)), 
       [Hsptl Gross Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross Other Land Value], 0)), 
       [Hsptl Gross Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross Other Building Value], 0)), 
       [Hsptl Gross Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross Other Total Value], 0)), 
       [Gen Exmpt Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [General Exemptions Land Value], 0)), 
       [Gen Exmpt Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [General Exemptions Building Value], 0)), 
       [Gen Exmpt Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [General Exemptions Total Value], 0)), 
       [Sch Exmpt Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [School Exemptions Land Value], 0)), 
       [Sch Exmpt Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [School Exemptions Building Value], 0)), 
       [Sch Exmpt Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [School Exemptions Total Value], 0)), 
       [Hsptl Exmpt Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Other Exemptions Land Value], 0)), 
       [Hsptl Exmpt Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Other Exemptions Building Value], 0)), 
       [Hsptl Exmpt Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Other Exemptions Total Value], 0)), 
       [Gen Net Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net General Land Value], 0)), 
       [Gen Net Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net General Building Value], 0)), 
       [Gen Net Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net General Total Value], 0)), 
       [Sch Net Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net School Land Value], 0)), 
       [Sch Net Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net School Building Value], 0)), 
       [Sch Net Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net School Total Value], 0)), 
       [Hsptl Net Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net Other Land Value], 0)), 
       [Hsptl Net Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net School Building Value], 0)), 
       [Hsptl Net Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net School Total Value], 0)), 
       [Gen Gross Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross General Land Value], 0)), 
       [Gen Gross Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross General Building Value], 0)), 
       [Gen Gross Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross General Total Value], 0)), 
       [Sch Gross Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross School Land Value], 0)), 
       [Sch Gross Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross School Building Value], 0)), 
       [Sch Gross Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross School Total Value], 0)), 
       [Hsptl Gross Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross Other Land Value], 0)), 
       [Hsptl Gross Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross Other Building Value], 0)), 
       [Hsptl Gross Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross Other Total Value], 0)), 
       [Gen Exmpt Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [General Exemptions Land Value], 0)), 
       [Gen Exmpt Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [General Exemptions Building Value], 0)), 
       [Gen Exmpt Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [General Exemptions Total Value], 0)), 
       [Sch Exmpt Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [School Exemptions Land Value], 0)), 
       [Sch Exmpt Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [School Exemptions Building Value], 0)), 
       [Sch Exmpt Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [School Exemptions Total Value], 0)), 
       [Hsptl Exmpt Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Other Exemptions Land Value], 0)), 
       [Hsptl Exmpt Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Other Exemptions Building Value], 0)), 
       [Hsptl Exmpt Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Other Exemptions Total Value], 0)), 
       [Gen Net Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net General Land Value], 0)), 
       [Gen Net Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net General Building Value], 0)), 
       [Gen Net Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net General Total Value], 0)), 
       [Sch Net Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net School Land Value], 0)), 
       [Sch Net Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net School Building Value], 0)), 
       [Sch Net Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net School Total Value], 0)), 
       [Hsptl Net Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net Other Land Value], 0)), 
       [Hsptl Net Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net School Building Value], 0)), 
       [Hsptl Net Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net School Total Value], 0)), 
       [Gen Gross Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross General Land Value], 0)), 
       [Gen Gross Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross General Building Value], 0)), 
       [Gen Gross Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross General Total Value], 0)), 
       [Sch Gross Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross School Land Value], 0)), 
       [Sch Gross Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross School Building Value], 0)), 
       [Sch Gross Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross School Total Value], 0)), 
       [Hsptl Gross Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross Other Land Value], 0)), 
       [Hsptl Gross Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross Other Building Value], 0)), 
       [Hsptl Gross Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross Other Total Value], 0)), 
       [Gen Exmpt Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [General Exemptions Land Value], 0)), 
       [Gen Exmpt Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [General Exemptions Building Value], 0)), 
       [Gen Exmpt Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [General Exemptions Total Value], 0)), 
       [Sch Exmpt Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [School Exemptions Land Value], 0)), 
       [Sch Exmpt Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [School Exemptions Building Value], 0)), 
       [Sch Exmpt Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [School Exemptions Total Value], 0)), 
       [Hsptl Exmpt Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Other Exemptions Land Value], 0)), 
       [Hsptl Exmpt Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Other Exemptions Building Value], 0)), 
       [Hsptl Exmpt Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Other Exemptions Total Value], 0)), 
       [Gen Net Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net General Land Value], 0)), 
       [Gen Net Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net General Building Value], 0)), 
       [Gen Net Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net General Total Value], 0)), 
       [Sch Net Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net School Land Value], 0)), 
       [Sch Net Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net School Building Value], 0)), 
       [Sch Net Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net School Total Value], 0)), 
       [Hsptl Net Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net Other Land Value], 0)), 
       [Hsptl Net Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net School Building Value], 0)), 
       [Hsptl Net Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net School Total Value], 0)), 
       [Gen Gross Land PC 02] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '02'
                                        THEN [Gross General Land Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Impr PC 02] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '02'
                                        THEN [Gross General Building Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Total PC 02] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '02'
                                         THEN [Gross General Total Value]
                                         ELSE 0
                                     END), 
       [Sch Gross Land PC 02] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '02'
                                        THEN [Gross School Land Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Impr PC 02] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '02'
                                        THEN [Gross School Building Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Total PC 02] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '02'
                                         THEN [Gross School Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Gross Land PC 02] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '02'
                                          THEN [Gross Other Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Impr PC 02] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '02'
                                          THEN [Gross Other Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Total PC 02] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '02'
                                           THEN [Gross Other Total Value]
                                           ELSE 0
                                       END), 
       [Gen Exmpt Land PC 02] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '02'
                                        THEN [General Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Impr PC 02] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '02'
                                        THEN [General Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Total PC 02] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '02'
                                         THEN [General Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Sch Exmpt Land PC 02] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '02'
                                        THEN [School Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Impr PC 02] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '02'
                                        THEN [School Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Total PC 02] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '02'
                                         THEN [School Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Exmpt Land PC 02] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '02'
                                          THEN [Other Exemptions Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Impr PC 02] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '02'
                                          THEN [Other Exemptions Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Total PC 02] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '02'
                                           THEN [Other Exemptions Total Value]
                                           ELSE 0
                                       END), 
       [Gen Net Land PC 02] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '02'
                                      THEN [Net General Land Value]
                                      ELSE 0
                                  END), 
       [Gen Net Impr PC 02] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '02'
                                      THEN [Net General Building Value]
                                      ELSE 0
                                  END), 
       [Gen Net Total PC 02] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '02'
                                       THEN [Net General Total Value]
                                       ELSE 0
                                   END), 
       [Sch Net Land PC 02] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '02'
                                      THEN [Net School Land Value]
                                      ELSE 0
                                  END), 
       [Sch Net Impr PC 02] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '02'
                                      THEN [Net School Building Value]
                                      ELSE 0
                                  END), 
       [Sch Net Total PC 02] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '02'
                                       THEN [Net School Total Value]
                                       ELSE 0
                                   END), 
       [Hsptl Net Land PC 02] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '02'
                                        THEN [Net Other Land Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Impr PC 02] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '02'
                                        THEN [Net Other Building Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Total PC 02] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '02'
                                         THEN [Net Other Total Value]
                                         ELSE 0
                                     END), 
       [Gen Gross Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross General Land Value], 0)), 
       [Gen Gross Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross General Building Value], 0)), 
       [Gen Gross Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross General Total Value], 0)), 
       [Sch Gross Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross School Land Value], 0)), 
       [Sch Gross Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross School Building Value], 0)), 
       [Sch Gross Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross School Total Value], 0)), 
       [Hsptl Gross Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross Other Land Value], 0)), 
       [Hsptl Gross Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross Other Building Value], 0)), 
       [Hsptl Gross Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross Other Total Value], 0)), 
       [Gen Exmpt Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [General Exemptions Land Value], 0)), 
       [Gen Exmpt Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [General Exemptions Building Value], 0)), 
       [Gen Exmpt Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [General Exemptions Total Value], 0)), 
       [Sch Exmpt Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [School Exemptions Land Value], 0)), 
       [Sch Exmpt Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [School Exemptions Building Value], 0)), 
       [Sch Exmpt Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [School Exemptions Total Value], 0)), 
       [Hsptl Exmpt Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Other Exemptions Land Value], 0)), 
       [Hsptl Exmpt Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Other Exemptions Building Value], 0)), 
       [Hsptl Exmpt Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Other Exemptions Total Value], 0)), 
       [Gen Net Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net General Land Value], 0)), 
       [Gen Net Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net General Building Value], 0)), 
       [Gen Net Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net General Total Value], 0)), 
       [Sch Net Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net School Land Value], 0)), 
       [Sch Net Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net School Building Value], 0)), 
       [Sch Net Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net School Total Value], 0)), 
       [Hsptl Net Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net Other Land Value], 0)), 
       [Hsptl Net Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net School Building Value], 0)), 
       [Hsptl Net Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net School Total Value], 0)), 
       [Gen Gross Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross General Land Value], 0)), 
       [Gen Gross Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross General Building Value], 0)), 
       [Gen Gross Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross General Total Value], 0)), 
       [Sch Gross Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross School Land Value], 0)), 
       [Sch Gross Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross School Building Value], 0)), 
       [Sch Gross Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross School Total Value], 0)), 
       [Hsptl Gross Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross Other Land Value], 0)), 
       [Hsptl Gross Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross Other Building Value], 0)), 
       [Hsptl Gross Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross Other Total Value], 0)), 
       [Gen Exmpt Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [General Exemptions Land Value], 0)), 
       [Gen Exmpt Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [General Exemptions Building Value], 0)), 
       [Gen Exmpt Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [General Exemptions Total Value], 0)), 
       [Sch Exmpt Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [School Exemptions Land Value], 0)), 
       [Sch Exmpt Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [School Exemptions Building Value], 0)), 
       [Sch Exmpt Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [School Exemptions Total Value], 0)), 
       [Hsptl Exmpt Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Other Exemptions Land Value], 0)), 
       [Hsptl Exmpt Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Other Exemptions Building Value], 0)), 
       [Hsptl Exmpt Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Other Exemptions Total Value], 0)), 
       [Gen Net Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net General Land Value], 0)), 
       [Gen Net Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net General Building Value], 0)), 
       [Gen Net Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net General Total Value], 0)), 
       [Sch Net Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net School Land Value], 0)), 
       [Sch Net Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net School Building Value], 0)), 
       [Sch Net Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net School Total Value], 0)), 
       [Hsptl Net Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net Other Land Value], 0)), 
       [Hsptl Net Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net School Building Value], 0)), 
       [Hsptl Net Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net School Total Value], 0)), 
       [Gen Gross Land PC 03] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '03'
                                        THEN [Gross General Land Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Impr PC 03] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '03'
                                        THEN [Gross General Building Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Total PC 03] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '03'
                                         THEN [Gross General Total Value]
                                         ELSE 0
                                     END), 
       [Sch Gross Land PC 03] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '03'
                                        THEN [Gross School Land Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Impr PC 03] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '03'
                                        THEN [Gross School Building Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Total PC 03] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '03'
                                         THEN [Gross School Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Gross Land PC 03] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '03'
                                          THEN [Gross Other Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Impr PC 03] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '03'
                                          THEN [Gross Other Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Total PC 03] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '03'
                                           THEN [Gross Other Total Value]
                                           ELSE 0
                                       END), 
       [Gen Exmpt Land PC 03] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '03'
                                        THEN [General Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Impr PC 03] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '03'
                                        THEN [General Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Total PC 03] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '03'
                                         THEN [General Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Sch Exmpt Land PC 03] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '03'
                                        THEN [School Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Impr PC 03] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '03'
                                        THEN [School Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Total PC 03] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '03'
                                         THEN [School Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Exmpt Land PC 03] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '03'
                                          THEN [Other Exemptions Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Impr PC 03] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '03'
                                          THEN [Other Exemptions Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Total PC 03] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '03'
                                           THEN [Other Exemptions Total Value]
                                           ELSE 0
                                       END), 
       [Gen Net Land PC 03] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '03'
                                      THEN [Net General Land Value]
                                      ELSE 0
                                  END), 
       [Gen Net Impr PC 03] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '03'
                                      THEN [Net General Building Value]
                                      ELSE 0
                                  END), 
       [Gen Net Total PC 03] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '03'
                                       THEN [Net General Total Value]
                                       ELSE 0
                                   END), 
       [Sch Net Land PC 03] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '03'
                                      THEN [Net School Land Value]
                                      ELSE 0
                                  END), 
       [Sch Net Impr PC 03] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '03'
                                      THEN [Net School Building Value]
                                      ELSE 0
                                  END), 
       [Sch Net Total PC 03] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '03'
                                       THEN [Net School Total Value]
                                       ELSE 0
                                   END), 
       [Hsptl Net Land PC 03] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '03'
                                        THEN [Net Other Land Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Impr PC 03] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '03'
                                        THEN [Net Other Building Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Total PC 03] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '03'
                                         THEN [Net Other Total Value]
                                         ELSE 0
                                     END), 
       [Gen Gross Land PC 04] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '04'
                                        THEN [Gross General Land Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Impr PC 04] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '04'
                                        THEN [Gross General Building Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Total PC 04] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '04'
                                         THEN [Gross General Total Value]
                                         ELSE 0
                                     END), 
       [Sch Gross Land PC 04] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '04'
                                        THEN [Gross School Land Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Impr PC 04] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '04'
                                        THEN [Gross School Building Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Total PC 04] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '04'
                                         THEN [Gross School Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Gross Land PC 04] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '04'
                                          THEN [Gross Other Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Impr PC 04] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '04'
                                          THEN [Gross Other Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Total PC 04] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '04'
                                           THEN [Gross Other Total Value]
                                           ELSE 0
                                       END), 
       [Gen Exmpt Land PC 04] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '04'
                                        THEN [General Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Impr PC 04] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '04'
                                        THEN [General Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Total PC 04] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '04'
                                         THEN [General Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Sch Exmpt Land PC 04] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '04'
                                        THEN [School Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Impr PC 04] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '04'
                                        THEN [School Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Total PC 04] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '04'
                                         THEN [School Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Exmpt Land PC 04] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '04'
                                          THEN [Other Exemptions Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Impr PC 04] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '04'
                                          THEN [Other Exemptions Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Total PC 04] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '04'
                                           THEN [Other Exemptions Total Value]
                                           ELSE 0
                                       END), 
       [Gen Net Land PC 04] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '04'
                                      THEN [Net General Land Value]
                                      ELSE 0
                                  END), 
       [Gen Net Impr PC 04] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '04'
                                      THEN [Net General Building Value]
                                      ELSE 0
                                  END), 
       [Gen Net Total PC 04] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '04'
                                       THEN [Net General Total Value]
                                       ELSE 0
                                   END), 
       [Sch Net Land PC 04] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '04'
                                      THEN [Net School Land Value]
                                      ELSE 0
                                  END), 
       [Sch Net Impr PC 04] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '04'
                                      THEN [Net School Building Value]
                                      ELSE 0
                                  END), 
       [Sch Net Total PC 04] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '04'
                                       THEN [Net School Total Value]
                                       ELSE 0
                                   END), 
       [Hsptl Net Land PC 04] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '04'
                                        THEN [Net Other Land Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Impr PC 04] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '04'
                                        THEN [Net Other Building Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Total PC 04] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '04'
                                         THEN [Net Other Total Value]
                                         ELSE 0
                                     END), 
       [Gen Gross Land PC 05] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '05'
                                        THEN [Gross General Land Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Impr PC 05] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '05'
                                        THEN [Gross General Building Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Total PC 05] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '05'
                                         THEN [Gross General Total Value]
                                         ELSE 0
                                     END), 
       [Sch Gross Land PC 05] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '05'
                                        THEN [Gross School Land Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Impr PC 05] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '05'
                                        THEN [Gross School Building Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Total PC 05] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '05'
                                         THEN [Gross School Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Gross Land PC 05] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '05'
                                          THEN [Gross Other Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Impr PC 05] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '05'
                                          THEN [Gross Other Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Total PC 05] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '05'
                                           THEN [Gross Other Total Value]
                                           ELSE 0
                                       END), 
       [Gen Exmpt Land PC 05] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '05'
                                        THEN [General Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Impr PC 05] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '05'
                                        THEN [General Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Total PC 05] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '05'
                                         THEN [General Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Sch Exmpt Land PC 05] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '05'
                                        THEN [School Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Impr PC 05] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '05'
                                        THEN [School Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Total PC 05] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '05'
                                         THEN [School Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Exmpt Land PC 05] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '05'
                                          THEN [Other Exemptions Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Impr PC 05] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '05'
                                          THEN [Other Exemptions Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Total PC 05] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '05'
                                           THEN [Other Exemptions Total Value]
                                           ELSE 0
                                       END), 
       [Gen Net Land PC 05] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '05'
                                      THEN [Net General Land Value]
                                      ELSE 0
                                  END), 
       [Gen Net Impr PC 05] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '05'
                                      THEN [Net General Building Value]
                                      ELSE 0
                                  END), 
       [Gen Net Total PC 05] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '05'
                                       THEN [Net General Total Value]
                                       ELSE 0
                                   END), 
       [Sch Net Land PC 05] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '05'
                                      THEN [Net School Land Value]
                                      ELSE 0
                                  END), 
       [Sch Net Impr PC 05] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '05'
                                      THEN [Net School Building Value]
                                      ELSE 0
                                  END), 
       [Sch Net Total PC 05] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '05'
                                       THEN [Net School Total Value]
                                       ELSE 0
                                   END), 
       [Hsptl Net Land PC 05] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '05'
                                        THEN [Net Other Land Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Impr PC 05] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '05'
                                        THEN [Net Other Building Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Total PC 05] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '05'
                                         THEN [Net Other Total Value]
                                         ELSE 0
                                     END), 
       [Gen Gross Land PC 06] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '06'
                                        THEN [Gross General Land Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Impr PC 06] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '06'
                                        THEN [Gross General Building Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Total PC 06] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '06'
                                         THEN [Gross General Total Value]
                                         ELSE 0
                                     END), 
       [Sch Gross Land PC 06] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '06'
                                        THEN [Gross School Land Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Impr PC 06] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '06'
                                        THEN [Gross School Building Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Total PC 06] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '06'
                                         THEN [Gross School Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Gross Land PC 06] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '06'
                                          THEN [Gross Other Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Impr PC 06] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '06'
                                          THEN [Gross Other Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Total PC 06] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '06'
                                           THEN [Gross Other Total Value]
                                           ELSE 0
                                       END), 
       [Gen Exmpt Land PC 06] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '06'
                                        THEN [General Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Impr PC 06] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '06'
                                        THEN [General Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Total PC 06] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '06'
                                         THEN [General Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Sch Exmpt Land PC 06] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '06'
                                        THEN [School Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Impr PC 06] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '06'
                                        THEN [School Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Total PC 06] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '06'
                                         THEN [School Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Exmpt Land PC 06] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '06'
                                          THEN [Other Exemptions Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Impr PC 06] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '06'
                                          THEN [Other Exemptions Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Total PC 06] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '06'
                                           THEN [Other Exemptions Total Value]
                                           ELSE 0
                                       END), 
       [Gen Net Land PC 06] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '06'
                                      THEN [Net General Land Value]
                                      ELSE 0
                                  END), 
       [Gen Net Impr PC 06] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '06'
                                      THEN [Net General Building Value]
                                      ELSE 0
                                  END), 
       [Gen Net Total PC 06] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '06'
                                       THEN [Net General Total Value]
                                       ELSE 0
                                   END), 
       [Sch Net Land PC 06] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '06'
                                      THEN [Net School Land Value]
                                      ELSE 0
                                  END), 
       [Sch Net Impr PC 06] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '06'
                                      THEN [Net School Building Value]
                                      ELSE 0
                                  END), 
       [Sch Net Total PC 06] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '06'
                                       THEN [Net School Total Value]
                                       ELSE 0
                                   END), 
       [Hsptl Net Land PC 06] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '06'
                                        THEN [Net Other Land Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Impr PC 06] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '06'
                                        THEN [Net Other Building Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Total PC 06] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '06'
                                         THEN [Net Other Total Value]
                                         ELSE 0
                                     END), 
       [Gen Gross Land PC 07] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '07'
                                        THEN [Gross General Land Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Impr PC 07] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '07'
                                        THEN [Gross General Building Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Total PC 07] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '07'
                                         THEN [Gross General Total Value]
                                         ELSE 0
                                     END), 
       [Sch Gross Land PC 07] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '07'
                                        THEN [Gross School Land Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Impr PC 07] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '07'
                                        THEN [Gross School Building Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Total PC 07] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '07'
                                         THEN [Gross School Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Gross Land PC 07] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '07'
                                          THEN [Gross Other Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Impr PC 07] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '07'
                                          THEN [Gross Other Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Total PC 07] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '07'
                                           THEN [Gross Other Total Value]
                                           ELSE 0
                                       END), 
       [Gen Exmpt Land PC 07] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '07'
                                        THEN [General Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Impr PC 07] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '07'
                                        THEN [General Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Total PC 07] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '07'
                                         THEN [General Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Sch Exmpt Land PC 07] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '07'
                                        THEN [School Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Impr PC 07] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '07'
                                        THEN [School Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Total PC 07] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '07'
                                         THEN [School Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Exmpt Land PC 07] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '07'
                                          THEN [Other Exemptions Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Impr PC 07] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '07'
                                          THEN [Other Exemptions Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Total PC 07] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '07'
                                           THEN [Other Exemptions Total Value]
                                           ELSE 0
                                       END), 
       [Gen Net Land PC 07] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '07'
                                      THEN [Net General Land Value]
                                      ELSE 0
                                  END), 
       [Gen Net Impr PC 07] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '07'
                                      THEN [Net General Building Value]
                                      ELSE 0
                                  END), 
       [Gen Net Total PC 07] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '07'
                                       THEN [Net General Total Value]
                                       ELSE 0
                                   END), 
       [Sch Net Land PC 07] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '07'
                                      THEN [Net School Land Value]
                                      ELSE 0
                                  END), 
       [Sch Net Impr PC 07] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '07'
                                      THEN [Net School Building Value]
                                      ELSE 0
                                  END), 
       [Sch Net Total PC 07] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '07'
                                       THEN [Net School Total Value]
                                       ELSE 0
                                   END), 
       [Hsptl Net Land PC 07] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '07'
                                        THEN [Net Other Land Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Impr PC 07] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '07'
                                        THEN [Net Other Building Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Total PC 07] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '07'
                                         THEN [Net Other Total Value]
                                         ELSE 0
                                     END), 
       [Gen Gross Land PC 08] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '08'
                                        THEN [Gross General Land Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Impr PC 08] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '08'
                                        THEN [Gross General Building Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Total PC 08] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '08'
                                         THEN [Gross General Total Value]
                                         ELSE 0
                                     END), 
       [Sch Gross Land PC 08] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '08'
                                        THEN [Gross School Land Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Impr PC 08] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '08'
                                        THEN [Gross School Building Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Total PC 08] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '08'
                                         THEN [Gross School Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Gross Land PC 08] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '08'
                                          THEN [Gross Other Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Impr PC 08] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '08'
                                          THEN [Gross Other Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Total PC 08] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '08'
                                           THEN [Gross Other Total Value]
                                           ELSE 0
                                       END), 
       [Gen Exmpt Land PC 08] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '08'
                                        THEN [General Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Impr PC 08] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '08'
                                        THEN [General Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Total PC 08] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '08'
                                         THEN [General Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Sch Exmpt Land PC 08] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '08'
                                        THEN [School Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Impr PC 08] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '08'
                                        THEN [School Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Total PC 08] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '08'
                                         THEN [School Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Exmpt Land PC 08] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '08'
                                          THEN [Other Exemptions Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Impr PC 08] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '08'
                                          THEN [Other Exemptions Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Total PC 08] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '08'
                                           THEN [Other Exemptions Total Value]
                                           ELSE 0
                                       END), 
       [Gen Net Land PC 08] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '08'
                                      THEN [Net General Land Value]
                                      ELSE 0
                                  END), 
       [Gen Net Impr PC 08] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '08'
                                      THEN [Net General Building Value]
                                      ELSE 0
                                  END), 
       [Gen Net Total PC 08] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '08'
                                       THEN [Net General Total Value]
                                       ELSE 0
                                   END), 
       [Sch Net Land PC 08] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '08'
                                      THEN [Net School Land Value]
                                      ELSE 0
                                  END), 
       [Sch Net Impr PC 08] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '08'
                                      THEN [Net School Building Value]
                                      ELSE 0
                                  END), 
       [Sch Net Total PC 08] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '08'
                                       THEN [Net School Total Value]
                                       ELSE 0
                                   END), 
       [Hsptl Net Land PC 08] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '08'
                                        THEN [Net Other Land Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Impr PC 08] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '08'
                                        THEN [Net Other Building Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Total PC 08] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '08'
                                         THEN [Net Other Total Value]
                                         ELSE 0
                                     END), 
       [Gen Gross Land PC 09] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '09'
                                        THEN [Gross General Land Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Impr PC 09] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '09'
                                        THEN [Gross General Building Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Total PC 09] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '09'
                                         THEN [Gross General Total Value]
                                         ELSE 0
                                     END), 
       [Sch Gross Land PC 09] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '09'
                                        THEN [Gross School Land Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Impr PC 09] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '09'
                                        THEN [Gross School Building Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Total PC 09] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '09'
                                         THEN [Gross School Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Gross Land PC 09] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '09'
                                          THEN [Gross Other Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Impr PC 09] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '09'
                                          THEN [Gross Other Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Total PC 09] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '09'
                                           THEN [Gross Other Total Value]
                                           ELSE 0
                                       END), 
       [Gen Exmpt Land PC 09] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '09'
                                        THEN [General Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Impr PC 09] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '09'
                                        THEN [General Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Total PC 09] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '09'
                                         THEN [General Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Sch Exmpt Land PC 09] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '09'
                                        THEN [School Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Impr PC 09] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '09'
                                        THEN [School Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Total PC 09] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '09'
                                         THEN [School Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Exmpt Land PC 09] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '09'
                                          THEN [Other Exemptions Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Impr PC 09] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '09'
                                          THEN [Other Exemptions Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Total PC 09] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '09'
                                           THEN [Other Exemptions Total Value]
                                           ELSE 0
                                       END), 
       [Gen Net Land PC 09] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '09'
                                      THEN [Net General Land Value]
                                      ELSE 0
                                  END), 
       [Gen Net Impr PC 09] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '09'
                                      THEN [Net General Building Value]
                                      ELSE 0
                                  END), 
       [Gen Net Total PC 09] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '09'
                                       THEN [Net General Total Value]
                                       ELSE 0
                                   END), 
       [Sch Net Land PC 09] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '09'
                                      THEN [Net School Land Value]
                                      ELSE 0
                                  END), 
       [Sch Net Impr PC 09] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '09'
                                      THEN [Net School Building Value]
                                      ELSE 0
                                  END), 
       [Sch Net Total PC 09] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '09'
                                       THEN [Net School Total Value]
                                       ELSE 0
                                   END), 
       [Hsptl Net Land PC 09] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '09'
                                        THEN [Net Other Land Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Impr PC 09] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '09'
                                        THEN [Net Other Building Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Total PC 09] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '09'
                                         THEN [Net Other Total Value]
                                         ELSE 0
                                     END), 
       [Gen Gross Land PC 10] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '10'
                                        THEN [Gross General Land Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Impr PC 10] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '10'
                                        THEN [Gross General Building Value]
                                        ELSE 0
                                    END), 
       [Gen Gross Total PC 10] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '10'
                                         THEN [Gross General Total Value]
                                         ELSE 0
                                     END), 
       [Sch Gross Land PC 10] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '10'
                                        THEN [Gross School Land Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Impr PC 10] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '10'
                                        THEN [Gross School Building Value]
                                        ELSE 0
                                    END), 
       [Sch Gross Total PC 10] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '10'
                                         THEN [Gross School Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Gross Land PC 10] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '10'
                                          THEN [Gross Other Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Impr PC 10] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '10'
                                          THEN [Gross Other Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Gross Total PC 10] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '10'
                                           THEN [Gross Other Total Value]
                                           ELSE 0
                                       END), 
       [Gen Exmpt Land PC 10] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '10'
                                        THEN [General Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Impr PC 10] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '10'
                                        THEN [General Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Gen Exmpt Total PC 10] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '10'
                                         THEN [General Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Sch Exmpt Land PC 10] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '10'
                                        THEN [School Exemptions Land Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Impr PC 10] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '10'
                                        THEN [School Exemptions Building Value]
                                        ELSE 0
                                    END), 
       [Sch Exmpt Total PC 10] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '10'
                                         THEN [School Exemptions Total Value]
                                         ELSE 0
                                     END), 
       [Hsptl Exmpt Land PC 10] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '10'
                                          THEN [Other Exemptions Land Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Impr PC 10] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '10'
                                          THEN [Other Exemptions Building Value]
                                          ELSE 0
                                      END), 
       [Hsptl Exmpt Total PC 10] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '10'
                                           THEN [Other Exemptions Total Value]
                                           ELSE 0
                                       END), 
       [Gen Net Land PC 10] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '10'
                                      THEN [Net General Land Value]
                                      ELSE 0
                                  END), 
       [Gen Net Impr PC 10] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '10'
                                      THEN [Net General Building Value]
                                      ELSE 0
                                  END), 
       [Gen Net Total PC 10] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '10'
                                       THEN [Net General Total Value]
                                       ELSE 0
                                   END), 
       [Sch Net Land PC 10] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '10'
                                      THEN [Net School Land Value]
                                      ELSE 0
                                  END), 
       [Sch Net Impr PC 10] = SUM(CASE
                                      WHEN [pc].[Property Class Code] = '10'
                                      THEN [Net School Building Value]
                                      ELSE 0
                                  END), 
       [Sch Net Total PC 10] = SUM(CASE
                                       WHEN [pc].[Property Class Code] = '10'
                                       THEN [Net School Total Value]
                                       ELSE 0
                                   END), 
       [Hsptl Net Land PC 10] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '10'
                                        THEN [Net Other Land Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Impr PC 10] = SUM(CASE
                                        WHEN [pc].[Property Class Code] = '10'
                                        THEN [Net Other Building Value]
                                        ELSE 0
                                    END), 
       [Hsptl Net Total PC 10] = SUM(CASE
                                         WHEN [pc].[Property Class Code] = '10'
                                         THEN [Net Other Total Value]
                                         ELSE 0
                                     END)
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FACT]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [dimFolio_SK] = 4703916
      AND [dimRollCycle_SK] = 87
GROUP BY [FACT].[dimFolio_SK],[FACT].[dimRollYear_SK];