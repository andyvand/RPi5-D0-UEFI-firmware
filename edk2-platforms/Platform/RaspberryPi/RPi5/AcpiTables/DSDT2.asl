DefinitionBlock ("Dsdt.aml", "DSDT", 2, "RPIFDN", "RPI5    ", 2)
{
  Scope (\_SB_)
  {
    Device (CPU0) {
      Name (_HID, "ACPI0007")
      Name (_UID, 0x0)
      Name (_STA, 0xf)
    }
    Device (CPU1) {
      Name (_HID, "ACPI0007")
      Name (_UID, 0x1)
      Name (_STA, 0xf)
    }
    Device (CPU2) {
      Name (_HID, "ACPI0007")
      Name (_UID, 0x2)
      Name (_STA, 0xf)
    }
    Device (CPU3) {
      Name (_HID, "ACPI0007")
      Name (_UID, 0x3)
      Name (_STA, 0xf)
    }
    Device (SOCB) {
      Name (_HID, "ACPI0004")
      Name (_UID, 0x0)
      Name (_CCA, 0x0)
      Method (_CRS, 0, Serialized) {
        Name (RBUF, ResourceTemplate () {
          QWordMemory (ResourceProducer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
        })
        CreateQWordField (RBUF, RB00._MIN, MI00) CreateQWordField (RBUF, RB00._MAX, MA00) CreateQWordField (RBUF, RB00._TRA, TR00) CreateQWordField (RBUF, RB00._LEN, LE00) LE00 = 0x4000000 MI00 = 0x107c000000 TR00 = 0 MA00 = MI00 + LE00 - 1
        Return (RBUF)
      }
      Name (_DMA, ResourceTemplate () {
        QWordMemory (ResourceProducer,
          PosDecode,
          MinFixed,
          MaxFixed,
          NonCacheable,
          ReadWrite,
          0x0,
          0x00000000C0000000,
          0x00000000FFFFFFFF,
          0xFFFFFFFF40000000,
          0x0000000040000000,
          ,
          ,
          )
      })
      Device (URT0) {
        Name (_HID, "ARMH0011")
        Name (_UID, 0x0)
        Name (_CCA, 0x0)
        Method (_CRS, 0x0, Serialized) {
          Name (RBUF, ResourceTemplate () {
            QWordMemory (ResourceConsumer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 152 }
          })
          CreateQWordField (RBUF, RB00._MIN, MI00) CreateQWordField (RBUF, RB00._MAX, MA00) CreateQWordField (RBUF, RB00._TRA, TR00) CreateQWordField (RBUF, RB00._LEN, LE00) LE00 = 0x200 MI00 = 0x107d001000 TR00 = 0 MA00 = MI00 + LE00 - 1
          Return (RBUF)
        }
        Name (_DSD, Package () {
          ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
          Package () {
            Package () { "clock-frequency", 44000000 }
          }
        })
      }
    }
    Name (PBMA, 0xAB)
    Name (BB32, 0xABCDEF0123456789)
    Name (MS32, 0xABCDEF0123456789)
    Device (PCI0) {
      Name (_SEG, 0)
      Name (_STA, 0xF)
      Name (CFGB, 0x1000100000)
      Name (CFGS, 0x9310)
      Name (MB32, 0x1700000000)
      Name (MB64, 0x1400000000)
      Name (MS64, 0x300000000)
      Name (_PRT, Package () {
        Package (4) { 0x0FFFF, 0, 0, 241 },
        Package (4) { 0x0FFFF, 1, 0, 242 },
        Package (4) { 0x0FFFF, 2, 0, 243 },
        Package (4) { 0x0FFFF, 3, 0, 244 }
      })
Name (_HID, "PNP0A08")
Name (_CID, "PNP0A03")
Name (_CCA, 0)
Name (_BBN, 0)
Method (_UID) {
  Return (_SEG)
}
Method (_INI, 0, Serialized) {
  OperationRegion (OCFG, SystemMemory, CFGB + 0x9000, 0x4)
  Field (OCFG, DWordAcc, NoLock, Preserve) {
    CFGI, 32
  }
  CFGI = 0x00100000
}
Method (_CRS, 0, Serialized) {
  Name (RBUF, ResourceTemplate () {
    WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
    QWordMemory (ResourceProducer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB01)
    QWordMemory (ResourceProducer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB02)
  })
  CreateWordField (RBUF, RB00._MIN, MI00) CreateWordField (RBUF, RB00._MAX, MA00) CreateWordField (RBUF, RB00._TRA, TR00) CreateWordField (RBUF, RB00._LEN, LE00) LE00 = (PBMA - _BBN) + 1 MI00 = _BBN TR00 = 0 MA00 = MI00 + LE00 - 1
  CreateQWordField (RBUF, RB01._MIN, MI01) CreateQWordField (RBUF, RB01._MAX, MA01) CreateQWordField (RBUF, RB01._TRA, TR01) CreateQWordField (RBUF, RB01._LEN, LE01) LE01 = MS32 MI01 = BB32 TR01 = MB32 - BB32 MA01 = MI01 + LE01 - 1
  CreateQWordField (RBUF, RB02._MIN, MI02) CreateQWordField (RBUF, RB02._MAX, MA02) CreateQWordField (RBUF, RB02._TRA, TR02) CreateQWordField (RBUF, RB02._LEN, LE02) LE02 = MS64 MI02 = MB64 TR02 = 0 MA02 = MI02 + LE02 - 1
  Return (RBUF)
}
Device (RES0) {
  Name (_HID, "AMZN0001")
  Name (_CID, "PNP0C02")
  Method (_UID) {
    Return (_SEG)
  }
  Method (_CRS, 0, Serialized) {
    Name (RBUF, ResourceTemplate () {
      QWordMemory (ResourceConsumer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
    })
    CreateQWordField (RBUF, RB00._MIN, MI00) CreateQWordField (RBUF, RB00._MAX, MA00) CreateQWordField (RBUF, RB00._TRA, TR00) CreateQWordField (RBUF, RB00._LEN, LE00) LE00 = 0x1000 MI00 = CFGB + 0x8000 TR00 = 0 MA00 = MI00 + LE00 - 1
    Return (RBUF)
  }
}
Name (SUPP, Zero)
Name (CTRL, Zero)
Method (_OSC, 4) {
  If (Arg0 == ToUUID ("33DB4D5B-1FF7-401C-9657-7441C03DD766")) {
    CreateDWordField (Arg3, 0, CDW1)
    CreateDWordField (Arg3, 4, CDW2)
    CreateDWordField (Arg3, 8, CDW3)
    SUPP = CDW2
    CTRL = CDW3
    CTRL &= 0x1E
    CTRL &= 0x1D
    If (Arg1 != 1) {
      CDW1 |= 0x08
    }
    If (CDW3 != CTRL) {
      CDW1 |= 0x10
    }
    CDW3 = CTRL
    Return (Arg3)
  } Else {
    CDW1 |= 4
    Return (Arg3)
  }
}
    }
    Device (PCI1) {
      Name (_SEG, 1)
      Name (_STA, 0xF)
      Name (CFGB, 0x1000110000)
      Name (CFGS, 0x9310)
      Name (MB32, 0x1b00000000)
      Name (MB64, 0x1800000000)
      Name (MS64, 0x300000000)
      Name (_PRT, Package () {
        Package (4) { 0x0FFFF, 0, 0, 251 },
        Package (4) { 0x0FFFF, 1, 0, 252 },
        Package (4) { 0x0FFFF, 2, 0, 253 },
        Package (4) { 0x0FFFF, 3, 0, 254 }
      })
Name (_HID, "PNP0A08")
Name (_CID, "PNP0A03")
Name (_CCA, 0)
Name (_BBN, 0)
Method (_UID) {
  Return (_SEG)
}
Method (_INI, 0, Serialized) {
  OperationRegion (OCFG, SystemMemory, CFGB + 0x9000, 0x4)
  Field (OCFG, DWordAcc, NoLock, Preserve) {
    CFGI, 32
  }
  CFGI = 0x00100000
}
Method (_CRS, 0, Serialized) {
  Name (RBUF, ResourceTemplate () {
    WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
    QWordMemory (ResourceProducer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB01)
    QWordMemory (ResourceProducer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB02)
  })
  CreateWordField (RBUF, RB00._MIN, MI00) CreateWordField (RBUF, RB00._MAX, MA00) CreateWordField (RBUF, RB00._TRA, TR00) CreateWordField (RBUF, RB00._LEN, LE00) LE00 = (PBMA - _BBN) + 1 MI00 = _BBN TR00 = 0 MA00 = MI00 + LE00 - 1
  CreateQWordField (RBUF, RB01._MIN, MI01) CreateQWordField (RBUF, RB01._MAX, MA01) CreateQWordField (RBUF, RB01._TRA, TR01) CreateQWordField (RBUF, RB01._LEN, LE01) LE01 = MS32 MI01 = BB32 TR01 = MB32 - BB32 MA01 = MI01 + LE01 - 1
  CreateQWordField (RBUF, RB02._MIN, MI02) CreateQWordField (RBUF, RB02._MAX, MA02) CreateQWordField (RBUF, RB02._TRA, TR02) CreateQWordField (RBUF, RB02._LEN, LE02) LE02 = MS64 MI02 = MB64 TR02 = 0 MA02 = MI02 + LE02 - 1
  Return (RBUF)
}
Device (RES0) {
  Name (_HID, "AMZN0001")
  Name (_CID, "PNP0C02")
  Method (_UID) {
    Return (_SEG)
  }
  Method (_CRS, 0, Serialized) {
    Name (RBUF, ResourceTemplate () {
      QWordMemory (ResourceConsumer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
    })
    CreateQWordField (RBUF, RB00._MIN, MI00) CreateQWordField (RBUF, RB00._MAX, MA00) CreateQWordField (RBUF, RB00._TRA, TR00) CreateQWordField (RBUF, RB00._LEN, LE00) LE00 = 0x1000 MI00 = CFGB + 0x8000 TR00 = 0 MA00 = MI00 + LE00 - 1
    Return (RBUF)
  }
}
Name (SUPP, Zero)
Name (CTRL, Zero)
Method (_OSC, 4) {
  If (Arg0 == ToUUID ("33DB4D5B-1FF7-401C-9657-7441C03DD766")) {
    CreateDWordField (Arg3, 0, CDW1)
    CreateDWordField (Arg3, 4, CDW2)
    CreateDWordField (Arg3, 8, CDW3)
    SUPP = CDW2
    CTRL = CDW3
    CTRL &= 0x1E
    CTRL &= 0x1D
    If (Arg1 != 1) {
      CDW1 |= 0x08
    }
    If (CDW3 != CTRL) {
      CDW1 |= 0x10
    }
    CDW3 = CTRL
    Return (Arg3)
  } Else {
    CDW1 |= 4
    Return (Arg3)
  }
}
    }
    Device (PCI2) {
      Name (_SEG, 2)
      Name (_STA, 0xF)
      Name (CFGB, 0x1000120000)
      Name (CFGS, 0x9310)
      Name (MB32, 0x1f00000000)
      Name (MB64, 0x1c00000000)
      Name (MS64, 0x300000000)
      Name (_PRT, Package () {
        Package (4) { 0x0FFFF, 0, 0, 261 },
        Package (4) { 0x0FFFF, 1, 0, 262 },
        Package (4) { 0x0FFFF, 2, 0, 263 },
        Package (4) { 0x0FFFF, 3, 0, 264 }
      })
Name (_HID, "PNP0A08")
Name (_CID, "PNP0A03")
Name (_CCA, 0)
Name (_BBN, 0)
Method (_UID) {
  Return (_SEG)
}
Method (_INI, 0, Serialized) {
  OperationRegion (OCFG, SystemMemory, CFGB + 0x9000, 0x4)
  Field (OCFG, DWordAcc, NoLock, Preserve) {
    CFGI, 32
  }
  CFGI = 0x00100000
}
Method (_CRS, 0, Serialized) {
  Name (RBUF, ResourceTemplate () {
    WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
    QWordMemory (ResourceProducer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB01)
    QWordMemory (ResourceProducer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB02)
  })
  CreateWordField (RBUF, RB00._MIN, MI00) CreateWordField (RBUF, RB00._MAX, MA00) CreateWordField (RBUF, RB00._TRA, TR00) CreateWordField (RBUF, RB00._LEN, LE00) LE00 = (PBMA - _BBN) + 1 MI00 = _BBN TR00 = 0 MA00 = MI00 + LE00 - 1
  CreateQWordField (RBUF, RB01._MIN, MI01) CreateQWordField (RBUF, RB01._MAX, MA01) CreateQWordField (RBUF, RB01._TRA, TR01) CreateQWordField (RBUF, RB01._LEN, LE01) LE01 = MS32 MI01 = BB32 TR01 = MB32 - BB32 MA01 = MI01 + LE01 - 1
  CreateQWordField (RBUF, RB02._MIN, MI02) CreateQWordField (RBUF, RB02._MAX, MA02) CreateQWordField (RBUF, RB02._TRA, TR02) CreateQWordField (RBUF, RB02._LEN, LE02) LE02 = MS64 MI02 = MB64 TR02 = 0 MA02 = MI02 + LE02 - 1
  Return (RBUF)
}
Device (RES0) {
  Name (_HID, "AMZN0001")
  Name (_CID, "PNP0C02")
  Method (_UID) {
    Return (_SEG)
  }
  Method (_CRS, 0, Serialized) {
    Name (RBUF, ResourceTemplate () {
      QWordMemory (ResourceConsumer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
    })
    CreateQWordField (RBUF, RB00._MIN, MI00) CreateQWordField (RBUF, RB00._MAX, MA00) CreateQWordField (RBUF, RB00._TRA, TR00) CreateQWordField (RBUF, RB00._LEN, LE00) LE00 = 0x1000 MI00 = CFGB + 0x8000 TR00 = 0 MA00 = MI00 + LE00 - 1
    Return (RBUF)
  }
}
Name (SUPP, Zero)
Name (CTRL, Zero)
Method (_OSC, 4) {
  If (Arg0 == ToUUID ("33DB4D5B-1FF7-401C-9657-7441C03DD766")) {
    CreateDWordField (Arg3, 0, CDW1)
    CreateDWordField (Arg3, 4, CDW2)
    CreateDWordField (Arg3, 8, CDW3)
    SUPP = CDW2
    CTRL = CDW3
    CTRL &= 0x1E
    CTRL &= 0x1D
    If (Arg1 != 1) {
      CDW1 |= 0x08
    }
    If (CDW3 != CTRL) {
      CDW1 |= 0x10
    }
    CDW3 = CTRL
    Return (Arg3)
  } Else {
    CDW1 |= 4
    Return (Arg3)
  }
}
    }
    Device (RP1B) {
      Name (_HID, "ACPI0004")
      Name (_UID, 0x1)
      Name (_CCA, 0x0)
      Name (PBAR, 0xABCDEF0123456789)
      Name (PINT, 261)
      Method (_STA) {
        If (PBAR == 0xABCDEF0123456789) {
          Return (0x0)
        }
        Return (0xF)
      }
Device (XHC0) {
  Name (_HID, "PNP0D10")
  Name (_UID, 0x0)
  Method (_CRS, 0, Serialized) {
    Name (RBUF, ResourceTemplate () {
      QWordMemory (ResourceConsumer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
      Interrupt (ResourceConsumer, Level, ActiveHigh, Shared,,, RB01) { 0 }
    })
    CreateQwordField (RBUF, RB00._MIN, MI00) CreateQwordField (RBUF, RB00._MAX, MA00) CreateQwordField (RBUF, RB00._LEN, LE00) LE00 = 0x00100000 MI00 = PBAR + 0x00200000 MA00 = MI00 + LE00 - 1
    CreateDwordField (RBUF, RB01._INT, IN01) IN01 = PINT
    Return (RBUF)
  }
}
Device (XHC1) {
  Name (_HID, "PNP0D10")
  Name (_UID, 0x1)
  Method (_CRS, 0, Serialized) {
    Name (RBUF, ResourceTemplate () {
      QWordMemory (ResourceConsumer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
      Interrupt (ResourceConsumer, Level, ActiveHigh, Shared,,, RB01) { 0 }
    })
    CreateQwordField (RBUF, RB00._MIN, MI00) CreateQwordField (RBUF, RB00._MAX, MA00) CreateQwordField (RBUF, RB00._LEN, LE00) LE00 = 0x00100000 MI00 = PBAR + 0x00300000 MA00 = MI00 + LE00 - 1
    CreateDwordField (RBUF, RB01._INT, IN01) IN01 = PINT
    Return (RBUF)
  }
}
    }
    Name (SDCM, 0x0)
    Name (SDLU, 0x0)
    Device (SDC0) {
      Method (_HID) {
        If (SDCM == 1) {
          Return ("80860F16")
        } Else {
          Return ("BRCM5D12")
        }
      }
      Name (_CID, Package () { "80860F16", "VEN_8086&DEV_0F14" })
      Name (_UID, 0x0)
      Name (_CCA, 0x0)
      Method (_CRS, 0x0, Serialized) {
        Name (RBUF, ResourceTemplate () {
          QWordMemory (ResourceConsumer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
          Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 305 }
        })
        CreateQWordField (RBUF, RB00._MIN, MI00) CreateQWordField (RBUF, RB00._MAX, MA00) CreateQWordField (RBUF, RB00._TRA, TR00) CreateQWordField (RBUF, RB00._LEN, LE00) LE00 = 0x260 MI00 = 0x1000fff000 TR00 = 0 MA00 = MI00 + LE00 - 1
        Return (RBUF)
      }
      OperationRegion (GPIO, SystemMemory, 0x107d517c00, 0x40)
      Field (GPIO, DWordAcc, NoLock, Preserve) {
        Offset (0x4),
        DATA, 32,
      }
      Method (_INI, 0, Serialized) {
        DATA &= ~(1 << 3)
      }
      Method (_DSM, 4, Serialized) {
        If (Arg0 == ToUUID ("f6c13ea5-65cd-461f-ab7a-29f7e8d5bd61")) {
          If (Arg1 >= 0) {
            Switch (ToInteger (Arg2)) {
              Case (0) {
                Return (Buffer () { 0x19, 0x01 })
              }
              Case (3) {
                DATA |= (1 << 3)
                Return (Buffer () { 0x00 })
              }
              Case (4) {
                DATA &= ~(1 << 3)
                Return (Buffer () { 0x00 })
              }
              Case (8) {
                If (SDLU == 1) {
                  Return (Buffer () { 0x02 })
                } Else {
                  Return (Buffer () { 0x0F })
                }
              }
            }
          }
        }
        Return (Buffer () { 0x0 })
      }
      Method (_DSD, 0, Serialized) {
        Name (CAPM, 0x0000000000000000)
        CAPM |= (1 << 47) | (1 << 46)
        If (SDLU == 1) {
          CAPM |= (1 << 33) | (1 << 32)
          If (SDCM != 1) {
            CAPM |= (1 << 34)
          }
        }
        Return (Package () {
          ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
          Package () {
            Package () { "sdhci-caps-mask", CAPM }
          }
        })
      }
      Device (SDMM) {
        Name (_ADR, 0x0)
        Method (_RMV) {
          Return (1)
        }
      }
    }
    Device (SDC1) {
      Name (_HID, "BRCM5D12")
      Name (_CID, Package () { "80860F16", "VEN_8086&DEV_0F14" })
      Name (_UID, 0x1)
      Name (_CCA, 0x0)
      Method (_CRS, 0x0, Serialized) {
        Name (RBUF, ResourceTemplate () {
          QWordMemory (ResourceConsumer,, MinFixed, MaxFixed, NonCacheable, ReadWrite, 0x0, 0x0, 0x0, 0x0, 0x1,,, RB00)
          Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 306 }
        })
        CreateQWordField (RBUF, RB00._MIN, MI00) CreateQWordField (RBUF, RB00._MAX, MA00) CreateQWordField (RBUF, RB00._TRA, TR00) CreateQWordField (RBUF, RB00._LEN, LE00) LE00 = 0x260 MI00 = 0x1001100000 TR00 = 0 MA00 = MI00 + LE00 - 1
        Return (RBUF)
      }
      Method (_DSM, 4, Serialized) {
        If (Arg0 == ToUUID ("f6c13ea5-65cd-461f-ab7a-29f7e8d5bd61")) {
          If (Arg1 >= 0) {
            Switch (ToInteger (Arg2)) {
              Case (0) {
                Return (Buffer () { 0x01, 0x01 })
              }
              Case (8) {
                Return (Buffer () { 0x02 })
              }
            }
          }
        }
        Return (Buffer () { 0x0 })
      }
      Method (_DSD, 0x0, Serialized) {
        Return (Package () {
          ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
          Package () {
            Package () { "sdhci-caps-mask", (1 << 47) | (1 << 46) | (1 << 33) | (1 << 32) },
          }
        })
      }
      Device (WLAN) {
        Name (_ADR, 0x1)
        Method (_RMV) {
          Return (0)
        }
      }
    }
  }
}
