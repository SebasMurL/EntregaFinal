﻿using lib_dominio.Entidades;
using lib_repositorios.Implementaciones;
using lib_repositorios.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ut_presentacion.Nucleo;

namespace ut_presentacion.Repositorio
{
    [TestClass]
    public class ProductosPrueba
    {
        private readonly IConexion? iConexion;
        private List<Productos>? lista;
        private Productos? entidad;

        public ProductosPrueba()
        {
            iConexion = new Conexion();
            iConexion.StringConexion = Configuracion.ObtenerValor("StringConexion");
        }

        [TestMethod]
        public void Ejecutar()
        {
            Assert.AreEqual(true, Relaciones());
            Assert.AreEqual(true, Guardar());
            Assert.AreEqual(true, Modificar());
            Assert.AreEqual(true, Listar());
            Assert.AreEqual(true, Borrar());
        }
        public bool Relaciones()
        {
            var categorias = this.iConexion!.Categorias!.FirstOrDefault(x => x.ID == 1);
            return true;
        }
        public bool Listar()
        {
            lista = iConexion!.Productos!.ToList();
            return lista.Count > 0;
        }

        public bool Guardar()
        {
            entidad = EntidadesNucleo.Productos()!;
            iConexion!.Productos!.Add(entidad);
            iConexion!.SaveChanges();
            return true;
        }

        public bool Modificar()
        {
            entidad!.Nombre = "Pepe";

            var entry = iConexion!.Entry<Productos>(entidad);
            entry.State = EntityState.Modified;
            iConexion!.SaveChanges();
            return true;
        }

        public bool Borrar()
        {
            iConexion!.Productos!.Remove(entidad!);
            iConexion!.SaveChanges();
            return true;
        }
    }
}
