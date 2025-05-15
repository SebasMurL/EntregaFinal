using lib_dominio.Entidades;
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
    public class VendedoresPrueba
    {
        private readonly IConexion? iConexion;
        private List<Vendedores>? lista;
        private Vendedores? entidad;

        public VendedoresPrueba()
        {
            iConexion = new Conexion();
            iConexion.StringConexion = Configuracion.ObtenerValor("StringConexion");
        }

        [TestMethod]
        public void Ejecutar()
        {
            Assert.AreEqual(true, Guardar());
            Assert.AreEqual(true, Modificar());
            Assert.AreEqual(true, Listar());
            Assert.AreEqual(true, Borrar());
        }

        public bool Listar()
        {
            lista = iConexion!.Vendedores!.ToList();
            return lista.Count > 0;
        }

        public bool Guardar()
        {
            entidad = EntidadesNucleo.Vendedores()!;
            iConexion!.Vendedores!.Add(entidad);
            iConexion!.SaveChanges();
            return true;
        }

        public bool Modificar()
        {
            entidad!.Nombre = "Pepe";
            var entry = iConexion!.Entry<Vendedores>(entidad);
            entry.State = EntityState.Modified;
            iConexion!.SaveChanges();
            return true;
        }

        public bool Borrar()
        {
            iConexion!. Vendedores!.Remove(entidad!);
            iConexion!.SaveChanges();
            return true;
        }
    }
}
