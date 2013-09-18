package DataStructures;

import java.util.LinkedList;
import java.lang.Runtime;
import java.io.*;

public class StokesParametersDataSet {
    public static class StokesParamSingleWavelengthSet implements Serializable {
        StokesParamSingleSet set;
        StokesParamSingleWavelengthSet(int W, int H) {
            set = new StokesParamSingleSet(W, H);
        }
    }
    public static class StokesParamSingleSet implements Serializable {
        float [] s0;
        float [] s1;
        float [] s2;
        float [] s3;
        StokesParamSingleSet(int W, int H) {
            s0 = new float[W * H];
            s1 = new float[W * H];
            s2 = new float[W * H];
            s3 = new float[W * H];
        }
    }
    public static class ActualStokesParametersDataSet implements Serializable {
        StokesParamSingleWavelengthSet [] wl_sets = new StokesParamSingleWavelengthSet[6];
        ActualStokesParametersDataSet(int W, int H) {
            wl_sets[1] = new StokesParamSingleWavelengthSet(W, H);
            wl_sets[2] = new StokesParamSingleWavelengthSet(W, H);
            wl_sets[3] = new StokesParamSingleWavelengthSet(W, H);
        }
    }

    private ActualStokesParametersDataSet _actual_set;
    private String _hash;
    static private LinkedList<StokesParametersDataSet> _stokes_sets = new LinkedList();

    private String _getHash() {
        return Integer.toString(_stokes_sets.indexOf(this));
    }

    static private void _serialize(String __hash, ActualStokesParametersDataSet __actual_set) {
        String path = "/home/laurent/" + __hash + ".hibernated"; // TODO
        try {
            FileOutputStream fos = new FileOutputStream(path);
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(__actual_set);
            oos.flush();
            oos.close();
            System.out.println(__actual_set.toString() + "serialized to [" + path + "]");
        } catch (Exception e) {
            System.out.println("Exception during serialization: " + e);
            System.exit(0);
        }
    }

    private boolean _hibernate() {
        if (_actual_set != null) {
            _hash = _getHash();
            _serialize(_hash, _actual_set);
            _actual_set = null;
            System.gc();
        }
        return _actual_set == null;// TODO
    }

    static private ActualStokesParametersDataSet _deserialize(String __hash) {
        String path = "/home/laurent/" + __hash + ".hibernated"; // TODO
        try {
            ActualStokesParametersDataSet __actual_set;
            FileInputStream fis = new FileInputStream(path);
            ObjectInputStream ois = new ObjectInputStream(fis);
            __actual_set = (ActualStokesParametersDataSet) ois.readObject();
            ois.close();
            System.out.println(__actual_set.toString() + "deserialized from [" + path + "]");
            return __actual_set;
        } catch (Exception e) {
            System.out.println("Exception during deserialization: " + e);
            System.exit(0);
        }
        return null;
    }

    private void _restore() {
        _actual_set = _deserialize(_hash);
        _hash = null;
    }

    public StokesParamSingleWavelengthSet wl_sets(int i) {
        if (_actual_set == null) {
            _restore();
        }
        if (_actual_set == null) {
            throw new RuntimeException("TODO");// TODO
        }
        return _actual_set.wl_sets[i];
    }

    private boolean _hibernateSomeDataSet() {
        boolean HIBERNATED = false;
        for (StokesParametersDataSet set : _stokes_sets) {
            if (set != null && set._actual_set != null) {
                HIBERNATED = set._hibernate();
                if (HIBERNATED) {
                    break;
                }
            }
        }
        return HIBERNATED;
    }

    public StokesParametersDataSet(int W, int H) throws OutOfMemoryError {
        boolean OK = true;
        OutOfMemoryError oome = null;
        while (OK) {
            try {
                _actual_set = new ActualStokesParametersDataSet(W, H);
                _stokes_sets.add(this);
                OK = true;
                break;
            } catch (OutOfMemoryError _oome) {
                OK = _hibernateSomeDataSet();
                if (!OK) {
                    oome = _oome;
                }
            }
        }
        if (!OK) {
            throw oome;
        }


        Runtime rt = Runtime.getRuntime();
        System.gc();
        System.out.println("[" + (_stokes_sets.size()) + "]" + ((rt.maxMemory() - rt.freeMemory()) / (1024 * 1024)) + "Mb / " + (rt.maxMemory() / (1024 * 1024)) + "Mb");
    }

    public static final int _W = 1000, _H = 1000;
    public static void main(String[] args) {
        LinkedList<StokesParametersDataSet> list = new LinkedList();
        while (true) {
            try {
                list.add(new StokesParametersDataSet(_W, _H));
            } catch (OutOfMemoryError oome) {
                oome.printStackTrace();
            }
        }
    }
}